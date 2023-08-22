puts 'Removing the restaurants...'
Restaurant.destroy_all
User.destroy_all

CHEFS = %w[Alan Aliia Alvin Andres Barry Caitlyn Dennis Devi Efren Gabrielle Gary George Horace James Jovon Kai Karthika Kostas Lili Lisa Mana Misako Naoki Noemi Nozomu PJ Ritsuki Vincent]
CATEGORIES = %W[burger burgers ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

def get_category(name)
  last_word = name.split.last.downcase
  CATEGORIES.include?(last_word) ? last_word : CATEGORIES.sample
end

users = [
  User.create(username: 'trouni', email: "trouni@me.com", password: 123123),
  User.create(username: 'dmbf29', email: "dmbf29@me.com", password: 123123)
]

puts "Creating #{CHEFS.count} Restaurants..."
CHEFS.shuffle.each do |name|
  restaurant_name = Faker::Restaurant.unique.name
  Restaurant.create!(
    name: "#{name}'s #{restaurant_name}",
    address: Faker::Address.street_address,
    rating: rand(1..5),
    description: Faker::Restaurant.description,
    category: get_category(restaurant_name),
    chef_name: name,
    user: users.sample
  )
end
puts "...created #{Restaurant.count} restaurants"

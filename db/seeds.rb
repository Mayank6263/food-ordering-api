# frozen_string_literal: true

# Restaurant
restro = Restaurant.create(name: 'Guru Kripa', address: 'near Allen Solley, Satya Sai Square, Indore')
restro1 = Restaurant.create(name: 'Pandit', address: 'Mangal city, Vijay nagar Square, Indore')
restro2 = Restaurant.create(name: 'Nanaksar', address: 'Dewas naka, Indore')
restro3 = Restaurant.create(name: 'Raja Ram dhaba', address: '78 Square, Indore')
restro4 = Restaurant.create(name: "Kunafa's", address: 'Meghdoot garden, Indore')
restro5 = Restaurant.create(name: 'Bapu ki Kutiya', address: 'Industry house, Indore')
restro6 = Restaurant.create(name: 'Kitchen mistry', address: 'Palasiiya Square, Indore')

restaurants = [restro, restro1, restro2, restro3, restro4, restro5, restro6]

restaurants.each do |restr|
  MenuItem.create(name: 'Sahi Paneer', price: 150, description: 'A high budget sahi paneer half-plate',
                  restaurant_id: restr.id)
  MenuItem.create(name: 'Paneer Tikka', price: 100, description: 'A spicy paneer tikka', restaurant_id: restr.id)
  MenuItem.create(name: 'Classic Margherita Pizza', price: 299,
                  description: 'A classic pizza with fresh mozzarella, basil, and tomato sauce.', restaurant_id: restr.id)
  MenuItem.create(name: 'Spicy Tofu Stir-Fry', price: 180,
                  description: 'Wok-fried tofu and fresh vegetables in a spicy garlic sauce.', restaurant_id: restr.id)
  MenuItem.create(name: 'Grilled Chicken Caesar Salad', price: 220,
                  description: 'Grilled chicken breast over crisp romaine lettuce with creamy Caesar dressing.', restaurant_id: restr.id)
  MenuItem.create(name: 'Vegetable Biryani', price: 160,
                  description: 'A fragrant mix of basmati rice, garden vegetables, and aromatic spices.', restaurant_id: restr.id)
  MenuItem.create(name: 'Cheeseburger Deluxe', price: 250,
                  description: 'A juicy beef patty topped with cheddar cheese, lettuce, tomato, and secret sauce.', restaurant_id: restr.id)
  MenuItem.create(name: 'Mushroom Risotto', price: 320,
                  description: 'Creamy arborio rice cooked with assorted wild mushrooms and parmesan cheese.', restaurant_id: restr.id)
  MenuItem.create(name: 'Paneer Tikka Masala', price: 190,
                  description: 'Cubes of paneer cheese in a rich, creamy, spiced tomato-based sauce.', restaurant_id: restr.id)
  MenuItem.create(name: 'Fish and Chips', price: 280,
                  description: 'Crispy battered fish served with thick-cut fries and tartar sauce.', restaurant_id: restr.id)
  MenuItem.create(name: 'Chocolate Lava Cake', price: 120,
                  description: 'A decadent chocolate cake with a gooey molten center, served with vanilla ice cream.', restaurant_id: restr.id)
  MenuItem.create(name: 'Iced Caramel Macchiato', price: 90,
                  description: 'Chilled espresso drink with milk, vanilla syrup, and a caramel drizzle.', restaurant_id: restr.id)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {name: 'Victor', password: 'UserPass', email: 'victor@gmail.com'},
  {name: 'Administrador', password: 'AdminPass', email: 'admin@gmail.com'},
]

users.each do |u|
  user = User.new
  user.name = u[:name]
  user.email = u[:email]
  user.password = u[:password]
  user.password_confirmation = u[:password]

  user.save!
end
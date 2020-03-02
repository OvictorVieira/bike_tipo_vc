# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new
user.name = 'Victor'
user.email = 'victor@gmail.com'
user.password = Rails.application.credentials[:seeds][:user][:password]
user.password_confirmation = Rails.application.credentials[:seeds][:user][:password]

user.save!

admin = Admin.new

admin.email = 'admin@admin.com'
admin.password = Rails.application.credentials[:seeds][:admin][:password]
admin.password_confirmation = Rails.application.credentials[:seeds][:admin][:password]

admin.save!
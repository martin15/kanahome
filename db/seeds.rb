# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.find_or_create_by(email: "martin.me15@yahoo.com") do |user|
  user.name = "Martin"
  user.password_digest = BCrypt::Password.create('1q2w3e4r5t').to_s
end
puts user.inspect

user = User.find_or_create_by(email: "theodora.tan@elektrigo.co.id") do |user|
  user.name = "Admin"
  user.password_digest = BCrypt::Password.create('KanahomeAdmin123').to_s
end
puts user.inspect

cat_1 = Category.find_or_create_by(name: "Kompor Induksi")
puts cat_1.inspect

cat_1 = Category.find_or_create_by(name: "kitchenware")
puts cat_1.inspect

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
Event.destroy_all
Attendance.destroy_all
u = []
e = []
chiffre_multiple_5 = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]

10.times do
u << User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: 20), email: Faker::Name.first_name + "@yopmail.com", encrypted_password: "fauxuser")
puts "User : #{Faker::Name.first_name}"
end

1.times do
e << Event.create(administrator: u.sample, start_date: Faker::Date.forward(days: 30), duration: chiffre_multiple_5.sample ,title: Faker::Book.title ,description: Faker::Lorem.sentence(word_count: 40) ,price: rand(1..1000) ,location: Faker::Address.city )
puts "Event: #{Faker::Book.title}"
end

5.times do
Attendance.create(user: u.sample, event: e.sample)
puts  "Attendance: #{u.sample.first_name} participera à l'évenement #{e.sample.title}"
end

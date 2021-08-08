# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
require 'faker'

coaches = []

10.times do
  coaches << Coach.create(name: Faker::Name.name )
end

coaches.each do |coach|
  10.times do
    course = Course.create(name: Faker::CryptoCoin.coin_name, self_assignable: true, coach: coach)
    Activity.create(name: Faker::Hobby.activity, course_id: course.id)
  end
end


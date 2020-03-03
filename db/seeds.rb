# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
rand(500..750).times do
  author = Author.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  rand(3..10).times do
    author.songs.create(
      title: Faker::Lorem.sentence,
      year: rand(1950..2019)
    )
  end
end

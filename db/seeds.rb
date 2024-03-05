# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user1 = User.create!(
  first_name: "Sam",
  last_name: "Yamashita",
  email: "sam@example.org",
  username: "samsam"
)
user2 = User.create!(
  first_name: "Adam",
  last_name: "Notodikromo",
  email: "adam@example.org",
  username: "adam123",
)

Bond.create(user: user1, friend: user2, state: Bond::FOLLOWING)
Bond.create(user: user2, friend: user1, state: Bond::FOLLOWING)
place = Place.create!(
  locale: "en",
  name: "Hotel Majapahit",
  place_type: "hotel",
  coordinate: "POINT (112.739898 -7.259836 0)"
)
post = Post.create!(user: user1, postable: Status.new(
  text: "Whohoo! I am in Surabaya!!!!"
))
Post.create!(user: user2, postable: Status.new(
  text: "Wow! Looks great! Have fun, Sam!"
), thread: post)
Post.create!(user: user1, postable: Status.new(
  text: "Ya! Ya! Ya! Are you in town?"
), thread: post)
Post.create!(user: user2, postable: Status.new(
  text: "Yups! Let's explore the city!"
), thread: post)
Post.create(user: user1, postable: Sight.new(
  place: place, activity_type: Sight::CHECKIN
))

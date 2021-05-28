# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  User.create(
    username: Faker::Internet.unique.user_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password,
    created_at: Faker::Time.between(15.days.ago, 10.days.ago, :all)
)
end

ForumThread.create(
  subject: "Game of Thrones",
  user_id: rand(1..10),
  created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )

5.times do
  ForumPost.create(
    forum_thread_id: 1,
    user_id: rand(1..10),
    title: Faker::GameOfThrones.house,
    body: Faker::GameOfThrones.quote,
    created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )
end

ForumThread.create(
  subject: "Harry Potter",
  user_id: rand(1..10),
  created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )

5.times do
  ForumPost.create(
    forum_thread_id: 2,
    user_id: rand(1..10),
    title: Faker::HarryPotter.book,
    body: Faker::HarryPotter.quote,
    created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )
end

ForumThread.create(
  subject: "How I Met Your Mother",
  user_id: rand(1..10),
  created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )

3.times do
  ForumPost.create(
    forum_thread_id: 3,
    user_id: rand(1..10),
    title: Faker::HowIMetYourMother.character,
    body: Faker::HowIMetYourMother.quote,
    created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )
end

ForumThread.create(
  subject: "Movies",
  user_id: rand(1..10),
  created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )

5.times do
  ForumPost.create(
    forum_thread_id: 4,
    user_id: rand(1..10),
    title: Faker::Simpsons.character,
    body: Faker::Simpsons.quote,
    created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )
end

ForumThread.create(
  subject: "Vehicle",
  user_id: rand(1..10),
  created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )

5.times do
  ForumPost.create(
    forum_thread_id: 5,
    user_id: rand(1..10),
    title: Faker::StarWars.character,
    body: Faker::StarWars.quote,
    created_at: Faker::Time.between(7.days.ago, Date.today, :all)
  )
end


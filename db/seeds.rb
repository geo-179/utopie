# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require "open-uri"

# Clear existing data
Comment.destroy_all
Post.destroy_all
User.destroy_all

puts "Destroyed all data 😈😈😈"

# Create 10 users

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    nickname: Faker::Name.name
  )

  puts "Generating user..."
  # Generate a sample photo for each user
  photo_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['person'])
  puts photo_url

  # Attach the photo using Cloudinary
  user.photo.attach(io: URI.open(photo_url), filename: "#{user.nickname}.jpg", content_type: 'image/png')

  # Save the user
  user.save!
end

puts "Created 10 users 👤👤👤"

# Create art-related posts

NUM_POSTS = 50

NUM_POSTS.times do
  title = Faker::Lorem.sentence(word_count: 3)
  content = Faker::Lorem.paragraph(sentence_count: 4)

  Post.create!(
    title: title,
    content: content,
    user: User.all.sample
  )
end

puts "#{NUM_POSTS} art-related posts have been created. 🎨🎨🎨"

# Create post-related comments

NUM_COMMENTS = 100

NUM_COMMENTS.times do
  content = Faker::Lorem.paragraph(sentence_count: 4)

  Comment.create!(
    content: content,
    post: Post.all.sample,
    user: User.all.sample
  )
end

puts "#{NUM_COMMENTS} art-related comments have been created. 😡😡😡"

puts "Done. 😊😊😊"

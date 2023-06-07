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
Like.destroy_all
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

NUM_POSTS = 10

NUM_POSTS.times do
  title = Faker::Lorem.sentence(word_count: 3)
  content = Faker::Lorem.paragraph(sentence_count: 4)

  post = Post.new(
    title: title,
    content: content,
    category: ["2D Visual Art", "3D Modeling", "Music Tech"].sample,
    user: User.all.sample
  )

  puts "Creating post..."

  url1 = Faker::LoremFlickr.image(size: "300x300", search_terms: ['person'])
  url2 = Faker::LoremFlickr.image(size: "300x300", search_terms: ['person'])
  url3 = Faker::LoremFlickr.image(size: "300x300", search_terms: ['person'])

  post.photos.attach([
    { io: URI.open(url1), filename: "#{post.title}-1.jpg", content_type: 'image/png' },
    { io: URI.open(url2), filename: "#{post.title}-2.jpg", content_type: 'image/png' },
    { io: URI.open(url3), filename: "#{post.title}-3.jpg", content_type: 'image/png' }
  ])

  post.save!

  user_for_likes = User.all.sample(rand(0..10))
  user_for_likes.each do |user|
    Like.create!(
      post: post,
      user: user
    )
  end

  puts "Randomized likes have been created for a post. 🥰🥰🥰"
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

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

# Create posts

post_one = Post.new(
  title: "graphic design website by Korneel Bostyn",
  content: "Amazing designer website!!!! Korneel Bostyn is a designer (1992) in Belgium, mostly interested in drawing, architecture, landscape, photography and tech.
  https://korneel.io/",
  category: "2D Visual Art",
  user: User.all.sample
)

post_two = Post.new(
  title: "decreation, artist website, graphic design",
  content: "https://decreation.studio/
  decreation is an independent creative practice manned by Dougal Henken.
  It is located on the internet and open 24/7",
  category: "2D Visual Art",
  user: User.all.sample
)

post_three = Post.new(
  title: "artist website, Jennifer Mehigan",
  content: "https://cowardess.online/
  Jennifer Mehigan is an artist and researcher based between Limerick and Belfast",
  category: "2D Visual Art",
  user: User.all.sample
)

post_four = Post.new(
  title: "世界物质档案 An online archive of the material world",
  content: "https://stuffmystuff.com/
  Found this yesterday. So interesting.
  This is an archive of the world matter, an online archive project begun in june 2010",
  category: "3D Modeling",
  user: User.all.sample
)

post_five = Post.new(
  title: "De Collectieve Collectie, recycling participatory art",
  content: "https://collectievecollectie.be/
  De Collectieve Collectie is een participatieve procedure die start vanuit het waarderen en (her)gebruiken van zwerfgoed. In samenwerking met deelnemers die alledaagse gebruiksvoorwerpen kiezen, schenken, benoemen, ordenen, classificeren, waarderen, assembleren, interpreteren, dragen en/of fotograferen, ontwikkelt kunstenaar Kristof Van Gestel voor deze procedure gaandeweg strategieën en technieken",
  category: "3D Modeling",
  user: User.all.sample
)

post_six = Post.new(
  title: "Insane artist Website, Sam Lyon, experimental animation",
  content: "https://www.jellygummies.com/
  Found this mind blowing 3D artist, soooooo cool! Sam Lyon who’s from Scotland and makes uncanny and experimental animations.
  https://www.jellygummies.com/#/special-deluxe-render-bender/ Crazy video… ",
  category: "3D Modeling",
  user: User.all.sample
)

post_seven = Post.new(
  title: "Creative coding: max msp with StyleGAN",
  content: "Check out this max msp programming with StyleGAN https://www.xiaohongshu.com/explore/646b4aba0000000013033200?app_platform=ios&app_version=7.89&share_from_user_hidden=true&type=video&xhsshare=WeixinSession&appuid=5f0764ea0000000001006d53&apptime=1686235984",
  category: "Music Tech",
  user: User.all.sample
)

post_eight = Post.new(
  title: "Live music programming with Gibber!!!",
  content: "Check out this live acid techno programming with Gibber
  https://www.xiaohongshu.com/explore/6471a2950000000013008951?app_platform=ios&app_version=7.89&share_from_user_hidden=true&type=video&xhsshare=WeixinSession&appuid=5f0764ea0000000001006d53&apptime=1686239568,
  official website is here
  https://gibber.cc/index.html",

  category: "Music Tech",
  user: User.all.sample
)

post_nine = Post.new(
  title: "Introduction to Pure Data",
  content: "A very basic introduction to Pure Data, live sound programming!
  https://www.youtube.com/watch?v=SLx7kjuFheY",
  category: "Music Tech",
  user: User.all.sample
)

post_ten = Post.new(
  title: "A very good Youtube course on introduction to Touch Designer",
  content: "
  bileam tschepe (elekktronaut)
  https://www.youtube.com/watch?v=Z_WfldiO6HI",
  category: "2D Visual Art",
  user: User.all.sample
)

puts "Creating post..."

url1 = "https://freight.cargo.site/t/original/i/9e3bc0835e4b4ed6a44bb4beb661cb442bad7620f979e44a5af7134acffa23c9/2Louis-70-dpi_tn-2.jpg"
url2 = "https://freight.cargo.site/t/original/i/45d5dafa4a6db96f700b490944698a09491022b77d8992a66652ccd6a51180a5/td72dpi.jpeg"
url3 = "https://freight.cargo.site/t/original/i/2a0ac91ffe5279e7db5eaf8c3dd953cff682296335938f91f0158caeb377ad11/92e.jpg"
url4 = "https://freight.cargo.site/t/original/i/880292ec67c52933051646d4ed58cf7bb4594166ac060929f06380a868fb8e15/DSC_2412-2.jpg"
url5 = "https://freight.cargo.site/w/2000/q/75/i/963a0e625ed00e01ace94bd2989d55cd187c4acadfac8346720a114e4905a992/RISD_POSTHUMAN_PROJ_2_feeling_graphic_poster_DOCUMENTATION.jpg"
url6 = "https://freight.cargo.site/t/original/i/a72c001ea688c8c394715e47efd57d904d52a7f02568cd30ea91f62e1fab7df8/COP_poster_BACK_CROP.png"
url7 = "https://freight.cargo.site/t/original/i/5e0e1b6f4ea40d13f01d34b4a881b6c52157f0633d91e364e641f24eddff4925/PXL_20220204_124148615.jpg"
url8 = "https://freight.cargo.site/t/original/i/bd90999970a40cd2d326a944a45902edbbff86f2dc899609fba67b357e51df77/Jennifer-Mehigan_DHG_300DPI-56.jpg"
url9 = "https://freight.cargo.site/t/original/i/19dfca1ae5abe3f6b4bcbd9f8a9d02523c0b39dc7f81ac38ef1c30ade1ca731e/Jennifer-Mehigan_DHG_300DPI-46.jpg"
url10 = "https://freight.cargo.site/w/700/q/75/i/eecbcb76b75585024871956472ea678d25b0803c60e34ce9479ccbfcc3933b57/00313.jpg"
url11 = "https://freight.cargo.site/w/700/q/75/i/8c14685f8f5cfd60bda0abe9d99f52438a605efd10999213258aa8985dc17e32/00240.jpg"
url12 = "https://freight.cargo.site/w/700/q/75/i/1589e0b2877e02232348c082666faa100c9f4de0ff3e2f913d39722c8ac985f4/00250.jpg"
url13 = "https://freight.cargo.site/t/original/i/1e08bbdccf03a563e0ae7c0bba24d33718a23edcb7bdc55ed4a4e76d8d3ea166/Image-364.jpg"
url14 = "https://freight.cargo.site/t/original/i/c8ed3ae8ca2a9bb79384e119e4fc87ca441f1a457eeb710fde26ae99603038d0/IMG_2158.jpg"
url15 = "https://freight.cargo.site/t/original/i/d506e0b489ff079a19b65c30dc9dda3d25716053ad782d6b8baef02fc40a33b0/Image-513.jpg"
url16 = "https://www.cartoonbrew.com/wp-content/uploads/2014/10/tumblr_n65pu9Y4CD1syjt2wo1_1280-1280x600.jpg"
url17 = "https://www.allcitycanvas.com/wp-content/uploads/2019/08/sam-lyon-gif-two.gif"
url18 = "https://hifructose.com/wp-content/uploads/2019/04/Sam3.jpg"
url19 = "https://www.ygzhang.com/images/cats/4.png"
url20 = "https://www.ygzhang.com/images/cats/8.png"
url21 = "https://www.ygzhang.com/images/cats/expo74_cats.jpg"
url22 = "https://gibber.cc/gibber_image.jpg"
url23 = "https://charlie-roberts.com/images/gibber_shader_no_shadow3.png"
url24 = "https://res.cloudinary.com/dgksx9vlc/image/upload/v1642086377/moodboard_vpusha.png"
url25 = "https://img.audiofanzine.com/images/u/product/normal/pd-iem-pure-data-10584.jpg"
url26 = "https://d29rinwu2hi5i3.cloudfront.net/article_media/8afba949-1bed-4430-a2f1-66561c73fe20/headline-pure-data-tutorial.jpg"
url27 = "https://www.mediamatic.net/image/2016/12/12/800px_screenshot10-403198495.png%28mediaclass-full-width.c3083fedae46a95f1139ff9d5833b1b6b8e20a69%29.jpg"
url28 = "https://www.lib.ncsu.edu/sites/default/files/touchdesigner.png"
url29 = "http://www.indaehwang.com/wp-content/uploads/2021/04/Screen-Shot-2021-04-08-at-2.05.41-pm.png"
url30 = "https://thenodeinstitute.org/wp-content/uploads/2023/03/TNI_Course_Cover_Intermediate_TD_SS23.jpg"

post_one.photos.attach([
  { io: URI.open(url1), filename: "#{post_one.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url2), filename: "#{post_one.title}-2.jpg", content_type: 'image/jpeg' },
  { io: URI.open(url3), filename: "#{post_one.title}-3.jpg", content_type: 'image/jpg' }
])

post_two.photos.attach([
  { io: URI.open(url4), filename: "#{post_two.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url5), filename: "#{post_two.title}-2.jpg", content_type: 'image/jpg' },
  { io: URI.open(url6), filename: "#{post_two.title}-3.jpg", content_type: 'image/png' }
])

post_three.photos.attach([
  { io: URI.open(url7), filename: "#{post_three.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url8), filename: "#{post_three.title}-2.jpg", content_type: 'image/jpg' },
  { io: URI.open(url9), filename: "#{post_three.title}-3.jpg", content_type: 'image/jpg' }
])

post_four.photos.attach([
  { io: URI.open(url10), filename: "#{post_four.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url11), filename: "#{post_four.title}-2.jpg", content_type: 'image/jpg' },
  { io: URI.open(url12), filename: "#{post_four.title}-3.jpg", content_type: 'image/jpg' }
])

post_five.photos.attach([
  { io: URI.open(url13), filename: "#{post_five.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url14), filename: "#{post_five.title}-2.jpg", content_type: 'image/jpg' },
  { io: URI.open(url15), filename: "#{post_five.title}-3.jpg", content_type: 'image/jpg' }
])

post_six.photos.attach([
  { io: URI.open(url16), filename: "#{post_six.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url17), filename: "#{post_six.title}-2.jpg", content_type: 'image/jpg' },
  { io: URI.open(url18), filename: "#{post_six.title}-3.jpg", content_type: 'image/jpg' }
])

post_seven.photos.attach([
  { io: URI.open(url19), filename: "#{post_seven.title}-1.jpg", content_type: 'image/png' },
  { io: URI.open(url20), filename: "#{post_seven.title}-2.jpg", content_type: 'image/png' },
  { io: URI.open(url21), filename: "#{post_seven.title}-3.jpg", content_type: 'image/jpg' }
])

post_eight.photos.attach([
  { io: URI.open(url22), filename: "#{post_eight.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url23), filename: "#{post_eight.title}-2.jpg", content_type: 'image/png' },
  { io: URI.open(url24), filename: "#{post_eight.title}-3.jpg", content_type: 'image/png' }
])

post_nine.photos.attach([
  { io: URI.open(url25), filename: "#{post_nine.title}-1.jpg", content_type: 'image/jpg' },
  { io: URI.open(url26), filename: "#{post_nine.title}-2.jpg", content_type: 'image/jpg' },
  { io: URI.open(url27), filename: "#{post_nine.title}-3.jpg", content_type: 'image/jpg' }
])

post_ten.photos.attach([
  { io: URI.open(url28), filename: "#{post_ten.title}-1.jpg", content_type: 'image/png' },
  { io: URI.open(url29), filename: "#{post_ten.title}-2.jpg", content_type: 'image/png' },
  { io: URI.open(url30), filename: "#{post_ten.title}-3.jpg", content_type: 'image/jpg' }
])


post_one.save!
post_two.save!
post_three.save!
post_four.save!
post_five.save!
post_six.save!
post_seven.save!
post_eight.save!
post_nine.save!
post_ten.save!
# post_eleven.save!
# post_twelve.save!
# post_thirteen.save!
# post_fourteen.save!
# post_fifteen.save!
# post_sixteen.save!
# post_seventeen.save!
# post_eighteen.save!


puts "Posts have been created!"


user_for_likes = User.all.sample(rand(0..10))
user_for_likes.each do |user|
  Post.all.each do |post|
    if [1,2].sample == 1
      Like.create!(
        post: post,
        user: user
      )
    end
  end
end

puts "Randomized likes have been created for a post. 🥰🥰🥰"
# end

puts "art-related posts have been created. 🎨🎨🎨"

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

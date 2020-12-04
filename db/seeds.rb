# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "password"

Reply.delete_all
VideoComment.delete_all
Comment.delete_all
PictureComment.delete_all
StoryComment.delete_all
Picture.delete_all
Post.delete_all
Story.delete_all
Video.delete_all
User.delete_all

super_user = User.create(
    name: "Forrest Wong",
    email: "forrest@mail.com",
    password: PASSWORD,
    admin: true
)

10.times do 
    name = Faker::Name.first_name 
    User.create( 
        name: name, 
        email: "#{name.downcase}@example.com", 
        password: PASSWORD 
    )  
end 

users = User.all

100.times do 
    user = users.sample
    p = Post.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::Movie.quote,
        view_count: rand(0...999),
        like_count: rand(0...999),
        user_id: user.id
    )
    if p.valid?
        rand(0..10).times do
            user = users.sample
            Comment.create(
                body: Faker::Movie.quote,
                post: p,
                user_id: user.id
            )
        end
    end
end 

100.times do 
    user = users.sample
    p = Story.create(
        title: Faker::Movie.quote,
        body: Faker::Hacker.say_something_smart,
        view_count: rand(0...999),
        user_id: user.id
    )
    if p.valid?
        rand(0..10).times do
            user = users.sample
            StoryComment.create(
                body: Faker::Movie.quote,
                story: p,
                user_id: user.id
            )
        end
    end
end 



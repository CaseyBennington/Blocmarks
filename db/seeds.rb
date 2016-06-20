# Create an admin user
admin = User.create!(
  name: 'admin',
  email: 'admin@example.com',
  password: 'password',
  confirmed_at: Faker::Date.between(1.year.ago, Date.today),
  confirmation_token: Faker::Internet.password(20, 20, true),
  role: 'admin'
)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

# Create a moderator member
moderator = User.create!(
  name: 'moderator',
  email: 'moderator@example.com',
  password: 'password',
  confirmed_at: Faker::Date.between(1.year.ago, Date.today),
  confirmation_token: Faker::Internet.password(20, 20, true),
  role: 'moderator'
)

# Create a standard member
member = User.create!(
  name: 'member',
  email: 'member@example.com',
  password: 'password',
  confirmed_at: Faker::Date.between(1.year.ago, Date.today),
  confirmation_token: Faker::Internet.password(20, 20, true)
)

# Create Users
5.times do
  User.create!(
    name: Faker::Name.first_name,
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password(10, 20, true, true),
    confirmed_at: Faker::Date.between(1.year.ago, Date.today),
    confirmation_token: Faker::Internet.password(20, 20, true)
  )
end
users = User.all

# Create topics
5.times do
  topic = Topic.create!(
    user: users.sample,
    title: Faker::App.name
  )
  topic.update_attribute(:created_at, Faker::Time.between(DateTime.now - 365, DateTime.now))
end
topics = Topic.all

# Create bookmarks
20.times do
  bookmark = Bookmark.create!(
    topic: topics.sample,
    url: Faker::Internet.url
  )
  bookmark.update_attribute(:created_at, Faker::Time.between(DateTime.now - 365, DateTime.now))
end
bookmarks = Bookmark.all

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"

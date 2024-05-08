# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#---- Roles ----

roles = [
  { name: 'Basic', permission: 1 },
  { name: 'Elavated', permission: 2 },
  { name: 'Extra Elavated', permission: 3 },
  { name: 'Admin', permission: 4 },
  { name: 'Counsel Member', permission: 5 },
]

roles.each do |role|
  Role.find_or_create_by(name: role[:name]) do |r|
    r.permission = role[:permission]
  end
end


#---- Ranks ----

ranks = [
  { name: "Novice", threshold: 10, level: 1 },
  { name: "Apprentice", threshold: 100, level: 2 },
  { name: "Journeyman", threshold: 500, level: 3 },
  { name: "Adept", threshold: 1000, level: 4 },
  { name: "Expert", threshold: 2000, level: 5 },
  { name: "Master", threshold: 4000, level: 6 },
  { name: "Grandmaster", threshold: 6000, level: 7 },
  { name: "Legendary", threshold: 8000, level: 8 },
  { name: "Mythical", threshold: 9000, level: 9 },
  { name: "Godlike", threshold: 10000, level: 10 },
  { name: "Transcendent", threshold: -1, level: 11 }
]

ranks.each do |rank|
  Rank.find_or_create_by(name: rank[:name]) do |r|
    r.level = rank[:level]
    r.threshold = rank[:threshold]
  end
end


#---- Users ----

users = [
  { email: 'root@root.com', username: 'Administrator', password: '12345678', password_confirmation: '12345678', rank: Rank.find_by(level: 11), xp: 1000, role: Role.find_by(name: "Counsel Member") },
]

users.each do |user|
  User.find_or_create_by(email: user[:email]) do |u|
    u.username = user[:username]
    u.password = user[:password]
    u.password_confirmation = user[:password_confirmation]
    u.rank = user[:rank]
    u.xp = user[:xp]
    u.role = user[:role]
  end
end


#----- random data

chargen = [
  -> { Faker::Movies::BackToTheFuture.character },
  -> { Faker::Movies::HarryPotter.character },
  -> { Faker::Movies::Hobbit.character },
  -> { Faker::Movies::HowToTrainYourDragon.character },
  -> { Faker::Movies::LordOfTheRings.character },
  -> { Faker::Movies::StarWars.character },
  -> { Faker::Movies::VForVendetta.character },
  -> { Faker::TvShows::BreakingBad.character },
  -> { Faker::TvShows::Spongebob.character },
  -> { Faker::TvShows::Simpsons.character }

]

textgen = [
  -> {  Faker::TvShows::FamilyGuy.quote },
  -> {  Faker::TvShows::RickAndMorty.quote },
  -> {  Faker::TvShows::Spongebob.quote },
  -> {  Faker::TvShows::SouthPark.quote },
  -> {  Faker::TvShows::Simpsons.quote },
  -> {  Faker::Quote.famous_last_words },
  -> {  Faker::Quote.yoda },
  -> {  Faker::Movie.quote },
  -> {  Faker::Movies::Hobbit.quote },
  -> {  Faker::Movies::StarWars.quote },
  -> {  Faker::Movies::VForVendetta.speech },
  -> {  Faker::Movies::VForVendetta.quote },
]

chargen.each do |generator|
  2.times do
    User.create(
      {
        username: generator.call,
        email: "#{Faker::Name.first_name}@#{Faker::Name.last_name}.com",
        password: '12345678',
        password_confirmation: '12345678',
        rank: Rank.find_by(level: 1),
        xp: 0,
        role: Role.find_by(name: 'Basic')
      }
    )
  end
end

textgen.each do |generator|
  2.times do
    user = User.order('RANDOM()').first
    user.update(xp: user.xp + 50)

    Question.new(
      {
        heading: Faker::Lorem.sentence(word_count: rand(1..5), supplemental: false, random_words_to_add: 0),
        text: generator.call,
        user: user
      }
    ).save
  end
end

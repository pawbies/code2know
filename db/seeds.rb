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
  { name: 'Noob', level: 1, threshold: 10 },
  { name: 'Beginner', level: 2, threshold: 100 },
  { name: 'Advanced', level: 3, threshold: 500 },
]

ranks.each do |rank|
  Rank.find_or_create_by(name: rank[:name]) do |r|
    r.level = rank[:level]
    r.threshold = rank[:threshold]
  end
end


#---- Users ----

users = [
  { email: 'Gay', username: 'Gay', password: 'Gay', password_confirmation: 'Gay', rank: Rank.find_by(name: "Advanced"), xp: 999, role: Role.find_by(name: "Counsel Member") },
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

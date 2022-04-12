# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'colorize'

# puts 'Seeding data for Status'.colorize(:green)
# Status.create name: 'Active', active: true
# Status.create name: 'Inactive', active: false

puts 'Seeding data for Group'.colorize(:green)
Group.create group_role: 'admin', group_name: 'Admin'
Group.create group_role: 'user', group_name: 'User'
Group.create group_role: 'viewer', group_name: 'Viewer'

puts 'Seeding data for Role'.colorize(:green)
Role.create name: 'read'
Role.create name: 'edit'
Role.create name: 'delete'

puts 'Seeding data for User'.colorize(:green)
40.times do
  user = User.new do |us|
    us.first_name = Faker::Name.first_name
    us.last_name = Faker::Name.last_name
    us.email = Faker::Internet.email
    us.username = Faker::Internet.username
    us.password = 'root'
    us.status = Status.all.sample
    us.group = Group.all.sample
  end
  user.build_ticket area: Faker::Sports::Football.position,
                    match: %(#{Faker::Sports::Football.team} - #{Faker::Sports::Football.team})
  user.save!
end

User.create do |user|
  user.first_name = 'root'
  user.last_name = 'root'
  user.email = 'root@gmail.com'
  user.username = 'root'
  user.password = 'root'
  user.group = Group.first
  user.status = Status.where(active: true).first
end

User.create do |user|
  user.first_name = 'root1'
  user.last_name = 'root1'
  user.email = 'root1@gmail.com'
  user.username = 'root1'
  user.password = 'root1'
  user.group = Group.first
  user.status = Status.where(active: true).first
end

100.times do
  group = Group.all.sample
  role = Role.all.sample
  group.roles << role unless group.roles.include? role
end

puts 'Seeding data for Message'.colorize(:green)
150.times do
  Message.create do |message|
    message.content = Faker::Lorem.paragraph
    message.read = [true, false].sample
    message.user = User.all.sample
  end
end

puts 'Seeding data for Book'.colorize(:green)
50.times do
  Book.create do |book|
    book.title = Faker::Book.title
    book.content = Faker::Lorem.paragraph
  end
end

puts 'Seeding data for Author'.colorize(:green)
20.times do
  Author.create do |author|
    author.name = Faker::Name.first_name + Faker::Name.last_name
  end
end

100.times do
  book = Book.all.sample
  author = Author.all.sample
  book.authors << author unless book.authors.include? author
end

100.times do
  book = Book.all.sample
  author = Author.all.sample
  author.books << book unless author.books.include? book
end

puts 'Seeding data for Schedule'.colorize(:green)
[%w[8:00 10:00], %w[10:00 12:00], %w[13:00 15:00], %w[15:00 17:00]].map do |item|
  Schedule.create do |schedule|
    schedule.time_start = item[0]
    schedule.time_end = item[1]
  end
end

puts 'Seeding data for Nurse'.colorize(:green)
20.times do
  nurse = Nurse.create(name: Faker::Name.name, phone: Faker::Number.number(digits: 10),
                       address: Faker::Address.street_address)
  nurse.save!
  Schedule.all.map do |schedule|
    NurseSchedule.create do |nurse_schedule|
      nurse_schedule.nurse = nurse
      nurse_schedule.schedule = schedule
    end
  end
end

puts 'Seeding data for Asset'.colorize(:green)
30.times do
  Asset.create name: Faker::Lorem.word
end

50.times do
  Asset.all.sample.children.create! name: Faker::Lorem.word
end

puts 'Seeding data for Tree'.colorize(:green)
30.times do
  tree = Tree.new name: Faker::Lorem.paragraph
  tree.save! if tree.valid?
end

200.times do
  parent = Tree.all.sample
  children = Tree.new name: Faker::Lorem.paragraph
  Tree.add_parent(parent, children) if children.valid?
end

puts 'Seeding data for LolChampion'.colorize(:green)
40.times do
  LolChampion.create do |lol|
    lol.name = Faker::Games::LeagueOfLegends.champion
    lol.location = Faker::Games::LeagueOfLegends.location
    lol.quote = Faker::Games::LeagueOfLegends.quote
    lol.summoner_spell = Faker::Games::LeagueOfLegends.summoner_spell
    lol.tree = Tree.all.sample
  end
end

puts 'Seeding data for PokemonPet'.colorize(:green)
40.times do
  PokemonPet.create do |pokemon|
    pokemon.name = Faker::Games::Pokemon.name
    pokemon.location = Faker::Games::Pokemon.location
    pokemon.move = Faker::Games::Pokemon.move
    pokemon.tree = Tree.all.sample
  end
end

puts 'Seeding data for MediaConan'.colorize(:green)
40.times do
  MediaConan.create do |conan|
    conan.character = Faker::JapaneseMedia::Conan.character
    conan.gadget = Faker::JapaneseMedia::Conan.gadget
    conan.vehicle = Faker::JapaneseMedia::Conan.vehicle
    conan.tree = Tree.all.sample
  end
end

puts 'Seeding data for MediaOnePiece'.colorize(:green)
40.times do
  MediaOnePiece.create do |one_piece|
    one_piece.character = Faker::JapaneseMedia::OnePiece.character
    one_piece.sea = Faker::JapaneseMedia::OnePiece.sea
    one_piece.location = Faker::JapaneseMedia::OnePiece.location
    one_piece.quote = Faker::JapaneseMedia::OnePiece.quote
    one_piece.skill = Faker::JapaneseMedia::OnePiece.akuma_no_mi
    one_piece.tree = Tree.all.sample
  end
end

puts 'Seeding data for Genre'.colorize(:green)
100.times do
  Genre.create!(name: Faker::Book.genre)
end

puts 'Seeding data for Article'.colorize(:green)
100.times do
  [].tap do |array|
    10.times do
      time = Time.current
      array << {
        title: Faker::Book.title,
        genre_id: rand(1..100),
        updated_at: time,
        created_at: time
      }
    end
    Article.insert_all!(array)
  end
end

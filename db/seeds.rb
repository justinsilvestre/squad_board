# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


PEOPLE = [
  { name: "Justin", avatar: File.open("#{Rails.root}/app/assets/images/avatars/donut.png") },
  { name: "Bustin", avatar: File.open("#{Rails.root}/app/assets/images/avatars/pusheenburger.jpg") },
  { name: "Fanana", avatar: File.open("#{Rails.root}/app/assets/images/avatars/illuminati.png") },
  { name: "Grommet", avatar: File.open("#{Rails.root}/app/assets/images/avatars/penguin.jpeg") },
  { name: "Boobafina", avatar: File.open("#{Rails.root}/app/assets/images/avatars/babysloth.jpeg") },
]

PEOPLE.each { |p| TeamMember.find_by(name: p[:name]) || TeamMember.create(p) }

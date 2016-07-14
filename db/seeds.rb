# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Person.destroy_all
Union.destroy_all
bassam = Person.create(first_name: 'Bassam',last_name: 'Pharaon')
dina = Person.create(first_name: 'Dina',last_name: 'Tash')
nisreen = Person.create(first_name: 'Nisreen',last_name: 'Pharaon')
zeid = Person.create(first_name: 'Zeid',last_name: 'Shubailat')
gaith = Person.create(first_name: 'Gaith',last_name: 'Shubailat')
union1 = Union.create(date: Date.new(1969), location: 'Amman, Jordan')
union2 = Union.create(date: Date.parse('2006-05-19'), location: 'Amman, Jordan')
union1.people << [bassam, dina, nisreen]
union2.people << [nisreen, zeid, gaith]
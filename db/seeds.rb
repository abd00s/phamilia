# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Person.destroy_all
Union.destroy_all
Relationship.destroy_all

afaf = Person.create(first_name: 'Afaf',last_name: 'Tabbaa',gender: 'F')
ar = Person.create(first_name: 'AR',last_name: 'Pharaon',gender: 'M')
bassam = Person.create(first_name: 'Bassam',last_name: 'Pharaon',gender: 'M')
dina = Person.create(first_name: 'Dina',last_name: 'Tash',gender: 'F')
nisreen = Person.create(first_name: 'Nisreen',last_name: 'Pharaon',gender: 'F', father: bassam, mother: dina)
yasmin = Person.create(first_name: 'Yasmin',last_name: 'Pharaon',gender: 'F', father: bassam, mother: dina)
zeid = Person.create(first_name: 'Zeid',last_name: 'Shubailat',gender: 'M')
gaith = Person.create(first_name: 'Gaith',last_name: 'Shubailat',gender: 'M', father: zeid, mother: nisreen)

union1 = Union.create(date: Date.new(1969), location: 'Amman, Jordan', husband: bassam, wife: dina)
union2 = Union.create(date: Date.parse('2006-05-19'), location: 'Amman, Jordan', husband: zeid, wife: nisreen)
union3 = Union.create(date: Date.new(1940), location: 'Amman, Jordan', husband: ar, wife: afaf)

union1.people << [bassam, dina, nisreen, yasmin]
union2.people << [nisreen, zeid, gaith]
union3.people << [bassam, afaf, ar]
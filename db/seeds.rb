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

zahra = Person.create(first_name: 'Zahra',last_name: 'Tabbaa',gender: 'M')
hashem = Person.create(first_name: 'Hashem',last_name: 'Tabbaa',gender: 'M')
nadia = Person.create(first_name: 'Nadia',last_name: 'Tabbaa',gender: 'F')
mans = Person.create(first_name: 'Mansour',last_name: 'Tabbaa',gender: 'M', father: hashem, mother: zahra)
tq = Person.create(first_name: 'Tawfiq',last_name: 'Tabbaa',gender: 'M', father: mans, mother: nadia)
afaf = Person.create(first_name: 'Afaf',last_name: 'Tabbaa',gender: 'F', father: hashem, mother: zahra)
ar = Person.create(first_name: 'AR',last_name: 'Pharaon',gender: 'M')
bassam = Person.create(first_name: 'Bassam',last_name: 'Pharaon',gender: 'M', father: ar, mother: afaf)
dina = Person.create(first_name: 'Dina',last_name: 'Tash',gender: 'F')
nisreen = Person.create(first_name: 'Nisreen',last_name: 'Pharaon',gender: 'F', father: bassam, mother: dina)
yasmin = Person.create(first_name: 'Yasmin',last_name: 'Pharaon',gender: 'F', father: bassam, mother: dina)
zein = Person.create(first_name: 'Zein',last_name: 'Shubailat',gender: 'F')
gaithsr = Person.create(first_name: 'Gaith',last_name: 'Shubailat',gender: 'M')
zeid = Person.create(first_name: 'Zeid',last_name: 'Shubailat',gender: 'M', father: gaithsr, mother: zein)
gaith = Person.create(first_name: 'Gaith',last_name: 'Shubailat',gender: 'M', father: zeid, mother: nisreen)
haya = Person.create(first_name: 'Haya',last_name: 'Shubailat',gender: 'F', father: gaithsr, mother: zein)
karim = Person.create(first_name: 'Karim',last_name: 'Tabba',gender: 'M', father: tq, mother: haya)

union1 = Union.create(date: Date.new(1969), location: 'Amman, Jordan', husband: bassam, wife: dina)
union2 = Union.create(date: Date.parse('2006-05-19'), location: 'Amman, Jordan', husband: zeid, wife: nisreen)
union3 = Union.create(date: Date.new(1940), location: 'Amman, Jordan', husband: ar, wife: afaf)
union4 = Union.create(date: Date.new(1940), location: 'Amman, Jordan', husband: mans, wife: nadia)
union5 = Union.create(date: Date.new(1940), location: 'Amman, Jordan', husband: hashem, wife: zahra)
union6 = Union.create(date: Date.new(2004), location: 'Amman, Jordan', husband: tq, wife: haya)
union7 = Union.create(date: Date.new(1960), location: 'Amman, Jordan', husband: gaithsr, wife: zein)

union1.people << [bassam, dina, nisreen, yasmin]
union2.people << [nisreen, zeid, gaith]
union3.people << [bassam, afaf, ar]
union4.people << [mans, nadia, tq]
union5.people << [hashem, zahra, mans, afaf]
union6.people << [tq, haya, karim]
union7.people << [gaithsr, zein, zeid, haya]
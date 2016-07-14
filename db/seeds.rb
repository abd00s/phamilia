# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
people = Person.create([{first_name: 'Bassam',last_name: 'Pharaon'},
                        {first_name: 'Dina',last_name: 'Tash'},
                        {first_name: 'Nisreen',last_name: 'Pharaon'},
                        {first_name: 'Zeid',last_name: 'Shubailat'},
                        {first_name: 'Gaith',last_name: 'Shubailat'}])
unions = Union.create([{date: Date.new('1969'), location: 'Amman, Jordan'},
                       {date: Date.parse('2006-05-19'), location: 'Amman, Jordan'}])
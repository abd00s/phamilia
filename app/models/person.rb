class Person < ActiveRecord::Base
  has_and_belongs_to_many :unions
  belongs_to :father, :class_name => Person, :foreign_key => 'father_id'
  belongs_to :mother, :class_name => Person, :foreign_key => 'mother_id'
end

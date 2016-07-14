class Person < ActiveRecord::Base
  has_and_belongs_to_many :unions
  has_one :union, :foreign_key => 'husband_id'
  has_one :union, :foreign_key => 'wife_id'
end

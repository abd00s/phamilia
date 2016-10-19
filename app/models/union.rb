class Union < ActiveRecord::Base
  has_and_belongs_to_many :people
  belongs_to :husband, :class_name => Person, :foreign_key => 'husband_id'
  belongs_to :wife, :class_name => Person, :foreign_key => 'wife_id'

  def children
    self.people.reject do |person|
      [self.husband_id, self.wife_id].include?(person.id)
    end
  end
end
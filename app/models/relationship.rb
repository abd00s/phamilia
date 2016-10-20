class Relationship < ActiveRecord::Base
  extend SetFirstOrderRelationships
  extend RelationshipBetween

  belongs_to :root, :class_name => "Person"
  belongs_to :target, :class_name => "Person"

  def self.of_order(num)
    where('coalesce(array_length(sequence, 1), 0) = ?', num - 1)
  end
end
class Relationship < ActiveRecord::Base
  extend SetFirstOrderRelationships
  extend RelationshipBetween

  belongs_to :root, :class_name => "Person"
  belongs_to :target, :class_name => "Person"
end
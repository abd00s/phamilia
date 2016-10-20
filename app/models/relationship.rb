class Relationship < ActiveRecord::Base
  extend SetFirstOrderRelationships
  extend RelationshipBetween
end
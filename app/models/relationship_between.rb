module RelationshipBetween
  def relationship_between(person_1, person_2)
    relationship = are_related?(person_1, person_2)

    return false unless relationship

    if relationship.first_order?
      are_related?(person_1, person_2).primitive_type
    else
      # Higher order logic
    end
  end

  def are_related?(person_1, person_2)
    if Relationship.find_by(root_id: person_1.id, target_id: person_2.id).present?
      Relationship.find_by(root_id: person_1.id, target_id: person_2.id)
    elsif Relationship.find_by(root_id: person_2.id, target_id: person_1.id).present?
      Relationship.find_by(root_id: person_2.id, target_id: person_1.id)
    else
      false
    end
  end
end
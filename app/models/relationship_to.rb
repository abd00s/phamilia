module RelationshipTo
  def relationship_to(target)

    # Case: Relationship to self
    if self.id == target.id
      return "#{target.first_name} is #{self.first_name}"
    end

    # Iterate on self's root relationships
    root_relationships.each do |relationship|

      # Case: A primitive type relationship exists
      if relationship.target.id == target.id
        connection = Relationship.find_by(root_id: self.id, target_id: target.id)
        return "#{target.first_name} is #{self.first_name}'s #{connection_name(connection)}"
      end

      relationship.target.root_relationships.of_order(1).each do |sub|
        # handle higher order relationships
      end
    end

  end

  def connection_name(relationship)
    case relationship.primitive_type
    when "child-parent"
     relationship.target.gender == "M" ? "father" : "mother"
    when "parent-child"
      relationship.target.gender == "M" ? "son" : "daughter"
    when "spouse"
      relationship.target.gender == "M" ? "husband" : "wife"
    when "sibling"
      relationship.target.gender == "M" ? "brother" : "sister"
    end
  end
end
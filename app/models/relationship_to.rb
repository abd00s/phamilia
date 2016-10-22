module RelationshipTo
  def relationship_to(target, stack=[], matches=[])

    # Case: Relationship to self
    if self.id == target.id
      return "#{target.first_name} is #{self.first_name}"
    end

    # Iterate on self's root relationships
    root_relationships.each do |relationship|

      # Case: A primitive type relationship exists
      if relationship.target.id == target.id  # probably need && first_order? true
        connection = Relationship.find_by(root_id: self.id, target_id: target.id)
        return "#{target.first_name} is #{self.first_name}'s #{connection_name(connection)}"
      end

      puts "rel #{relationship.target.first_name}"

      stack.push(relationship.target)

      relationship.target.root_relationships.of_order(1).each do |sub|
        # handle higher order relationships
        if sub.target_id == target.id
          matches << stack.dup
        end
        # stack[-1].relationship_to(target, stack, matches) unless stack.length == 3
      end
      stack.pop

    end
    return matches
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
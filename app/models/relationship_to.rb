module RelationshipTo
  def relationship_to(target, stack=[], matches=[])

    stack.push(self) if stack.empty?

    # Case: Relationship to self
    if self.id == target.id
      return "#{target.first_name} is #{self.first_name}"
    end

    # Iterate on self's root relationships
    root_relationships.each do |relationship|
      next if stack.include?(relationship.target)
      # Case: A primitive type relationship exists
      if relationship.target.id == target.id  # probably need && first_order? true
        connection = Relationship.find_by(root_id: self.id, target_id: target.id)
        return "#{target.first_name} is #{self.first_name}'s #{connection_name(connection)}"
      end

      stack.push(relationship.target)

      nodes_to_visit = relationship.target.root_relationships.reject do |node|
        node.target_id == self.id || \
        self.root_relationships.map{|r| r.target_id }.include?(node.target_id) || \
        stack.include?(node.target_id)
      end

      nodes_to_visit.each do |node|
        if node.target_id == target.id
          matches << stack.dup
        else
        node.target.relationship_to(target, stack, matches)
        end
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
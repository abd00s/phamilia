module RelationshipTo
  def relationship_to(target, stack=[], matches=[])
    stack.push(self)

    nodes_to_visit = self.root_relationships.reject do |node|
      stack.include?(node.target) ||
      (stack[-2].present? && stack[-2].connections_array.include?(node.target))
    end

    nodes_to_visit.each do |node|
      if node.target_id == target.id
        matches << stack.dup
      else
        node.target.relationship_to(target, stack, matches)

        stack.pop
      end
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
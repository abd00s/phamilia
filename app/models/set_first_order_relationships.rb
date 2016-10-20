module SetFirstOrderRelationships
  def set_first_order_relationships
    Person.all.each do |person|
      person.connections.each_key do |key|    # Keys [:parents, :spouse, :children, :siblings]
        Relationship.assign_group(key, person)
      end
    end
  end

  def assign_group(key, root)
    primitive_type = Relationship.primitive_type_name(key)
    root.connections[key].each do |destination|
      unless Relationship.relationship_exists?(root, destination)
        Relationship.create_primitive_relationship(root, destination, primitive_type)
      end
    end
  end

  def create_primitive_relationship(root, destination, primitive_type)
    Relationship.create!(
      root_id: root.id,
      destination_id: destination.id,
      primitive_type: primitive_type,
      first_order?: true
    )
  end

  def relationship_exists?(root, destination)
    Relationship.exists?(root_id: root.id, destination_id: destination.id) ||
    Relationship.exists?(root_id: destination.id, destination_id: root.id)
  end

  def primitive_type_name(key)
    case key
    when :parents then "child-parent"
    when :spouse then "spouse"
    when :children then "parent-child"
    when :siblings then "sibling"
    end
  end
end
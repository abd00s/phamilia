module SetFirstOrderRelationships
  def set_first_order_relationships
    Person.all.each do |person|
      person.connections.each_key do |key|    # Keys [:parents, :spouse, :children, :siblings]
        assign_group(key, person)
      end
    end
  end

  def assign_group(key, root)
    primitive_type = primitive_type_name(key)
    root.connections[key].each do |target|
      unless relationship_exists?(root, target)
        create_primitive_relationship(root, target, primitive_type)
      end
    end
  end

  def create_primitive_relationship(root, target, primitive_type)
    Relationship.create!(
      root_id: root.id,
      target_id: target.id,
      primitive_type: primitive_type,
      first_order?: true
    )

    if ["child-parent", "parent-child"].include?(primitive_type)
      primitive_type = primitive_type == "parent-child" ? "child-parent" : "parent-child"
    end

    Relationship.create!(
      root_id: target.id,
      target_id: root.id,
      primitive_type: primitive_type,
      first_order?: true
    )
  end

  def relationship_exists?(root, target)
    Relationship.exists?(root_id: root.id, target_id: target.id)
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
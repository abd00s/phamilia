module RelationshipToAnnotated
  def relationship_to_2(target, stack=[], matches=[], count=0)
    # ActiveRecord::Base.logger = nil

    # Start building stack representing path from ROOT to TARGET
    # First element in the stack is the ROOT person
    stack.push(self)

    # Utility output to inspect progress at every recursive call
    # Tab indentation helps visualize the level of the recursive calls
    puts "#{"\t" * count }self is #{self.first_name}"
    puts "#{"\t" * count }stack is #{stack.map{|p|p.first_name}}"
    puts "#{"\t" * count }matches is #{matches.map{|m| m.map{|s| s.first_name}}}"

    # # Utility output to visualize correctness of "visit node?" logic
    # self.root_relationships.each do |r|
    #   puts "#{"\t" * count }==================="
    #   puts "#{"\t" * count }Node is #{r.target.first_name}"
    #   puts "#{"\t" * count }C1 is #{stack.include?(r.target)}"
    #   puts "#{"\t" * count }C2 is #{stack[-2].present? && stack[-2].connections_array.include?(r.target)}"
    #   puts "#{"\t" * count }==================="
    # end

    # Determining what nodes to visit next. Begin by looking at nodes directly
    # connected to current node. i.e. primitive-type relationships [Parent-Child,
    # Child-Parent, Sibling, Spouse]
    nodes_to_visit = self.root_relationships.reject do |node|
      # Reject nodes that have already been visited (i.e. avoid cycle)
      stack.include?(node.target) ||
      # Reject nodes that are directly related to someone who's already been
      # visited. (Only possible w/ one generation offset)
      (stack[-2].present? && stack[-2].connections_array.include?(node.target))
    end

    nodes_to_visit.each do |node|
      # Visit nodes determined "to-visit"
      puts "#{"\t" * count }visiting: #{node.target.first_name}"
      if node.target_id == target.id
        puts "#{"\t" * count }matched stack is #{stack.map{|p|p.first_name}}"
        puts "#{"\t" * count }MATCH"
        # If our target is found, add to matches the path it took to get there
        # We push a duplicate of stack so that when we later `pop`, the copy in
        # matches is not mutated
        matches << stack.dup
      else
        # If the node isn't our target, visit it's nodes.
        # We increment count by 1 simply for clearer output visualization
        node.target.relationship_to_2(target, stack, matches, count + 1)
        # Remove the last element in the stack because it does not lead us in
        # a direct path to our target.
        stack.pop
      end
    end
    # Return all paths leading from ROOT to TARGET. Array of arrays
    return matches
  end
end
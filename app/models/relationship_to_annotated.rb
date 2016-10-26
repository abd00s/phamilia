module RelationshipToAnnotated
  def relationship_to_2(target, stack=[], matches=[], count=0)
    # ActiveRecord::Base.logger = nil
    stack.push(self)
    puts "#{"\t" * count }self is #{self.first_name}"
    puts "#{"\t" * count }stack is #{stack.map{|p|p.first_name}}"
    puts "#{"\t" * count }matches is #{matches.map{|m| m.map{|s| s.first_name}}}"

    self.root_relationships.each do |r|
      puts "#{"\t" * count }==================="
      puts "#{"\t" * count }Node is #{r.target.first_name}"
      puts "#{"\t" * count }C1 is #{stack.include?(r.target)}"
      puts "#{"\t" * count }C2 is #{stack[-2].present? && stack[-2].connections_array.include?(r.target)}"
      puts "#{"\t" * count }==================="
    end

    nodes_to_visit = self.root_relationships.reject do |node|
      stack.include?(node.target) ||
      (stack[-2].present? && stack[-2].connections_array.include?(node.target))
    end

    nodes_to_visit.each do |node|
      puts "#{"\t" * count }visiting: #{node.target.first_name}"
      if node.target_id == target.id
        puts "#{"\t" * count }matched stack is #{stack.map{|p|p.first_name}}"
        puts "#{"\t" * count }MATCH"
        matches << stack.dup
      else
        count += 1
        node.target.relationship_to_2(target, stack, matches, count)
        count -= 1
        stack.pop
      end
    end
    return matches
  end
end
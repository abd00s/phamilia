module SetHigherOrderRelationships
# First order relationships are set

# People.each (person) Nisreen
### person.root_relationships.of_order(1).each (relationship) Bassam
### ### relationship.root.each (root_person)  AR
### ### ### Create a 2nd order relationship with each root_person
### ### ### Sequence = root_person ==  Rel: Root N, Target AR
### ### ### =========================  Stack: [B]

### person.root_relationships.of_order(2).each (relationship) AR
### ### relationship.root.each (root_person)  MH
### ### ### Create a 2nd order relationship with each root_person
### ### ### Sequence = root_person ==  Rel: Root N, Target MH
### ### ### =========================  Stack: [B, AR]

### person.root_relationships.of_order(3).each (relationship) MH
### ### relationship.root.each (root_person)  RSH
### ### ### Create a 3rd order relationship with each root_person
### ### ### Sequence = root_person ==  Rel: Root N, Target RSH
### ### ### =========================  Stack: [B, AR, MH]
  def set_higher_order #(2nd order of gaith)
    Person.find_by(first_name: "Gaith").root_relationships.each do |relationship| #now of order 1
      puts relationship.target.first_name
      stack = [relationship.target.id]
      relationship.target.root_relationships.of_order(1).each do |sub|
        # if self
        next if sub.target.id == Person.find_by(first_name: "Gaith").id
        next if Relationship.exists?(root: Person.find_by(first_name: "Gaith"), target: sub.target, first_order?: true)
        puts "===#{sub.target.first_name}"
        puts "in"

        Relationship.create!(
          root_id: Person.find_by(first_name: "Gaith").id,
          target_id: sub.target.id,
          sequence: stack
        )

        Relationship.create!(
          root_id: sub.target.id,
          target_id: Person.find_by(first_name: "Gaith").id,
          sequence: stack
        )
      end
    end
  end
end
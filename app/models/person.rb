class Person < ActiveRecord::Base
  has_and_belongs_to_many :unions
  belongs_to :father, :class_name => Person, :foreign_key => 'father_id'
  belongs_to :mother, :class_name => Person, :foreign_key => 'mother_id'

  def parent_in #union(s)
    parent_id =
      if self.gender == 'M'
        "husband_id"
      else
        "wife_id"
      end

    Union.where("#{parent_id}": self.id)
  end

  def children
    parent_in.collect {|union| union.children}
  end

end

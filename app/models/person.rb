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
    parent_in.collect{|union| union.children}.flatten
  end

  def spouse
    return nil if parent_in.empty?

    spouse_title =
      if self.gender == 'M'
        "wife"
      else
        "husband"
      end

    parent_in
      .reject{|union| union.divorced?}
      .first
      .send "#{spouse_title}"
  end

  def child_in
    (unions - parent_in).first
  end

  def siblings
    child_in.present? ? child_in.children.reject{|child| child.id == self.id} : []
  end

  def connections
    connected_individuals = Array.new
    connected_individuals << self.father if self.father.present?
    connected_individuals << self.mother if self.mother.present?
    connected_individuals << self.spouse if self.spouse.present?
    self.children.each{|child| connected_individuals << child}
    self.siblings.each{|sibling| connected_individuals << sibling}
    return connected_individuals
  end
end
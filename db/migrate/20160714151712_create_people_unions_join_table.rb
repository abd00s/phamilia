class CreatePeopleUnionsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :people, :unions do |t|
      t.index :person_id
      t.index :union_id
    end
  end
end

class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :last_name_alt_spelling
      t.string :gender
      t.date :dob
      t.string :pob
      t.boolean :deceased?
      t.date :dod
      t.string :pod
      t.text :comments

      t.timestamps null: false
    end
  end
end

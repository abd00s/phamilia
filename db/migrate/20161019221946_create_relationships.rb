class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :root_id
      t.integer :destination_id
      t.boolean :first_order?
      t.text :sequence, array: true, default: []

      t.timestamps null: false
    end
  end
end

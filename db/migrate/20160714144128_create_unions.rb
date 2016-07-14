class CreateUnions < ActiveRecord::Migration
  def change
    create_table :unions do |t|
      t.date :date
      t.string :location
      t.boolean :divorced?, default: false

      t.timestamps null: false
    end
  end
end

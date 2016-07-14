class AddMotherAndFatherToUnion < ActiveRecord::Migration
  def change
    add_column :unions, :father_id, :integer
    add_column :unions, :mother_id, :integer
  end
end

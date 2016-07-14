class RenameMotherAndFatherToHusbandAndWife < ActiveRecord::Migration
  def change
    rename_column :unions, :father_id, :husband_id
    rename_column :unions, :mother_id, :wife_id
  end
end

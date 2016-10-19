class AddPrimitiveTypeColumnToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :primitive_type, :string
  end
end

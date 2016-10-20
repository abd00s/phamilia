class RenameDestinationIdColumnToTargetIdInRelationships < ActiveRecord::Migration
  def change
    rename_column :relationships, :destination_id, :target_id
  end
end

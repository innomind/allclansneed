class RenamedRightTypeToComponentIdInUserRight < ActiveRecord::Migration
  def self.up
    rename_column :user_rights, :right_type, :component_id
  end

  def self.down
    rename_column :user_rights, :component_id, :right_type
  end
end
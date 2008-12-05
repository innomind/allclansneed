class ChangeUserRightLevelToRightType < ActiveRecord::Migration
  def self.up
    change_table :user_rights do |t|
      t.remove :level
      t.integer :right_type
    end
  end

  def self.down
    change_table :user_rights do |t|
      t.remove :right_type
      t.integer :level
    end
  end
end

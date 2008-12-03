class CreateRightComponents < ActiveRecord::Migration
  def self.up
    create_table :right_components do |t|
      t.belongs_to :user_right
      t.belongs_to :component
      t.timestamps
    end
  end

  def self.down
    drop_table :right_components
  end
end

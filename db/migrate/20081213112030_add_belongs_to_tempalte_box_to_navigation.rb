class AddBelongsToTempalteBoxToNavigation < ActiveRecord::Migration
  def self.up
    add_column :navigations, :template_box_id, :integer
  end

  def self.down
    remove_column :navigations, :tempalte_box_id
  end
end

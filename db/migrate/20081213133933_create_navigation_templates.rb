class CreateNavigationTemplates < ActiveRecord::Migration
  def self.up
    create_table :navigation_templates do |t|
      t.string :controller, :action, :name
      t.timestamps
    end
    
    add_column :navigations, :navigation_template_id, :integer
  end

  def self.down
    drop_table :navigation_templates
    remove_column :navigations, :navigation_template_id
  end
end

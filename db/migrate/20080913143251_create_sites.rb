class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.column :title, :string
      t.column :sub_domain, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end

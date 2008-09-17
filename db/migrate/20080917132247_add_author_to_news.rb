class AddAuthorToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :author_id, :integer
  end

  def self.down
    remove_column :news, :author_id
  end
end

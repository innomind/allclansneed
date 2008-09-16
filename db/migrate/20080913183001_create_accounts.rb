class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer  :site_id
      t.string :nick
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password, :limit => 64
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end

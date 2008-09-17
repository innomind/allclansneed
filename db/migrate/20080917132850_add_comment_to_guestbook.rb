class AddCommentToGuestbook < ActiveRecord::Migration
  def self.up
    add_column :guestbooks, :comment, :text
    add_column :guestbooks, :comment_author_id, :integer
  end

  def self.down
    remove_column :guestbooks, :comment
    remove_column :guestbooks, :comment_author_id
  end
end

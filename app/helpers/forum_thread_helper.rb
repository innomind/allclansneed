module ForumThreadHelper
  def new_thread_link anchor
    eval "new_#{anchor.class.name.downcase}_forum_thread_path(#{anchor.id})"
  end
end
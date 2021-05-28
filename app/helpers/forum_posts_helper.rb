# frozen_string_literal: true

module ForumPostsHelper
  def ya_postulo(user_id, forum_thread_id)
    Request.all.each do |request|
      if (request.user_id == user_id) &&
         (request.forum_thread_id == forum_thread_id)
        return true
      else
        return false
      end
    end
    false
  end
end

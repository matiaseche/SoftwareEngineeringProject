# frozen_string_literal: true

json.array! @forum_posts, partial: 'forum_posts/forum_post', as: :forum_post

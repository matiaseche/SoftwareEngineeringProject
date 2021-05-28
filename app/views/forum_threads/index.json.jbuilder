# frozen_string_literal: true

json.array! @forum_threads, partial: 'forum_threads/forum_thread',
                            as: :forum_thread

# frozen_string_literal: true

json.extract! poll, :id, :question, :user_id,
              :forum_thread_id, :created_at, :updated_at
json.url poll_url(poll, format: :json)

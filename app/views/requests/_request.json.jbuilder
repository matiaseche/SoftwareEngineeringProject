# frozen_string_literal: true

json.extract! request, :id, :user_id, :forum_thread_id, :created_at, :updated_at
json.url request_url(request, format: :json)

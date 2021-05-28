# frozen_string_literal: true

json.array! @polls, partial: 'polls/poll', as: :poll

# frozen_string_literal: true

module UsersHelper
  def normalimage
    "http://graph.facebook.com/#{uid}/picture?type=normal"
  end
end

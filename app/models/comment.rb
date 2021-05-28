# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :forum_post, dependent: :destroy

  validates :content, presence: true

  acts_as_likeable
  acts_as_votable
end

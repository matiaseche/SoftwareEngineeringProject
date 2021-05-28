# frozen_string_literal: true

class ForumPost < ApplicationRecord
  belongs_to :user
  belongs_to :forum_thread
  has_many   :comments, dependent: :destroy

  validates :body, presence: true
  validates :title, presence: true

  acts_as_likeable
  acts_as_followable
  acts_as_votable
end

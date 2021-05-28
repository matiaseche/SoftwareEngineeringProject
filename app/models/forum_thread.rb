# frozen_string_literal: true

class ForumThread < ApplicationRecord
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :polls, dependent: :destroy

  validates :subject, presence: true

  acts_as_followable
end

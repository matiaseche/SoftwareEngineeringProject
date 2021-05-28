# frozen_string_literal: true

class Poll < ApplicationRecord
  belongs_to :user
  belongs_to :forum_thread
  has_many :answers, dependent: :destroy

  validates :question, presence: true
  accepts_nested_attributes_for :answers
end

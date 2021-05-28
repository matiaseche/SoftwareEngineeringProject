# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :poll, dependent: :destroy

  acts_as_votable
end

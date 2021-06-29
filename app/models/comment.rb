# frozen_string_literal: true

# Class to define the comments entity
class Comment < ApplicationRecord
  include Visible
  belongs_to :article

  validates :score, inclusion: { in: (1..5).to_a }

  # Condition verification
  validates :commenter, presence: true
  validates :body, presence: true
end

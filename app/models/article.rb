# frozen_string_literal: true

# Class to define the articles entity
class Article < ApplicationRecord
  include Visible

  # Relations
  belongs_to :user
  has_many :comments, dependent: :destroy

  # Condition verification
  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  # Define comments score method
  def score
    l = comments.length.to_f
    return 0 if l.zero?

    (comments.reduce(0) { |p, a| p + a.score } / l).round(1)
  end
end

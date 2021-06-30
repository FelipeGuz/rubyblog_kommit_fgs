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
end

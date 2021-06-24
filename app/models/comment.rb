# frozen_string_literal: true

# Class to define the comments entity
class Comment < ApplicationRecord
  include Visible
  belongs_to :article
end

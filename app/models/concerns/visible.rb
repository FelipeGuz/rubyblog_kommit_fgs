# frozen_string_literal: true

# Module to deal with the visibility of articles and comments
module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = %w[public private archived]

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  class_methods do
    def public_count
      where(status: 'public').count
    end
  end

  def archived?
    status == 'archived'
  end
end

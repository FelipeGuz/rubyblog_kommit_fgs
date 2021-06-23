class Article < ApplicationRecord
    include Visible
    
    # Relations
    has_many :comments, dependent: :destroy

    # Condition verification
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}
end

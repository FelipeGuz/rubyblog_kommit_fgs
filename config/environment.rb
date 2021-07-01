# Load the Rails application.
require_relative 'application'

# Config of errors in rails
ActionView::Base.field_error_proc = proc do |html_tag, _|
  html_tag.html_safe
end

# Initialize the Rails application.
Rails.application.initialize!

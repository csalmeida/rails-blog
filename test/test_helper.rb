ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require "minitest/pride"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_as(user, password)
    # This took me a while to achieve. Here's what I missed:
    # The route needed to be plural as in "sessions" and not "session"
    # The credentials do not need to be wrapped in a sessions hash like
    # in other cases because of how the form is structured
    post sessions_url, params: { email: user.email, password: password }
  end

end


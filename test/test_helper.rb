require 'simplecov'
SimpleCov.start 'rails' do
  enable_coverage :branch

  # Adding filters removes the matched files from being included in the test coverage:

  # It's a temporary compatibility fix:
  add_filter '/app/controllers/turbo_devise_controller.rb'
end
# At some point, we can define a minmum coverage that will result in a non-zero exit of SimpleCov if the required coverage is not reached:
# SimpleCov.minimum_coverage line: 90, branch: 80
# The following would make sure that new changes do not result in a drop of coverage:
# SimpleCov.refuse_coverage_drop :line, :branch

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  # TestCase class
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

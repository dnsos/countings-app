if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails' do
    enable_coverage :branch

    # Adding filters removes the matched files from being included in the test coverage:

    # It's a temporary compatibility fix:
    add_filter '/app/controllers/turbo_devise_controller.rb'

    # No mailers at the moment:
    add_filter '/app/mailers/application_mailer.rb'

    # No jobs at the moment:
    add_filter '/app/jobs/application_job.rb'

    # Nothings cable-related at the moment:
    add_filter '/app/channels'

    # Customized Devise controllers with only modifications of the callback paths. These should be tested in system tests of the sign in/up/out flow:
    add_filter '/app/controllers/users'

    # At some point, we can define a minmum coverage that will result in a non-zero exit of SimpleCov if the required coverage is not reached:
    # SimpleCov.minimum_coverage line: 90, branch: 80
    # The following would make sure that new changes do not result in a drop of coverage:
    # SimpleCov.refuse_coverage_drop :line, :branch
  end
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  # TestCase class
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # If tests run with coverage requested we handle parallelization via https://github.com/simplecov-ruby/simplecov/issues/718#issuecomment-538201587
    if ENV['COVERAGE']
      parallelize_setup do |worker|
        SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
      end

      parallelize_teardown { SimpleCov.result }
    end

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

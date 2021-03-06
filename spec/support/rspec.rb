RSpec.configure do |config|
  # Set the default mocking library
  config.mock_with :rspec

  # Only run tests that have this filter, if it exists
  config.filter_run debug: true

  # Run all the tests when all the tests are filtered
  config.run_all_when_everything_filtered = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Capybara::DSL
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
end

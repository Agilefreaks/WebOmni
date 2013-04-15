RSpec.configure do |config|
  # Set the default mocking library
  config.mock_with :rspec

  # Only run tests that have this filter, if it exists
  config.filter_run :debug => true

  # Run all the tests when all the tests are filtered
  config.run_all_when_everything_filtered = true

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end
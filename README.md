# Countings App

## Features

### Geolocations

Each counting has geolocations associated with it. All users and visitors are able to view geolocations because they are aggregated on district level and are therefore anonymous.

> This may become more granular in the future.

The aggregation is achieved with a model `District` that holds all Berlin districts with a PostGIS-powered column `geometry` which stores the multipolygon outline of each district and its `name`. An association model `Geolocation` links countings with districts (TBD).

## Testing

We use Rails' built-in `minitest` for testing. Its features cover all the use cases of this app. Conventionally find the tests in the `test/` folder.

### Test coverage

Test coverage is tracked with [SimpleCov](https://github.com/simplecov-ruby/simplecov). Each test run generates a new coverage report at `coverage/index.html` (folder is gitignored). SimpleCov is configured in `test/test_helper.rb`. For now, no minimum coverage is required.

> Test coverage does not include system tests.

### Running tests locally

Run all tests (except the slower system tests that boot up a real browser):

```bash
bin/rails test
```

Run all tests including system tests:

```bash
bin/rails test:all
```

Run only the system tests:

```bash
bin/rails test:system
```

Run only specific test suites:

```bash
bin/rails test test/controllers/countings_controller_test.rb
```

> Or any other path to the desired test suite.

### Running tests in CI

In the GitHub Action `.github/workflows/rubyonrails.yml`, we run all tests including the system tests with `bin/rails test:all`.

# Countings App

## Features

The main business logic of this app is that it maps the latitude & longitude of a `Countee` to one of the stored `District`'s. If a district is found the countee is saved (along with their other data). Important to note is that the exact latitude and longitude are never stored anywhere, so to keep the anonymity of the countee.

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

### Running tests locally with test coverage output

```bash
COVERAGE=true bin/rails test
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

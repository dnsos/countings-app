# Countings App

## Testing

We use Rails' built-in `minitest` for testing. Its features cover all the use cases of this app. Conventionally find the tests in the `test/` folder.

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

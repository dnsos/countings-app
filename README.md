# Countings App

This repository contains the code for the Countings App, a fictional web app inspired by a Berlin-based initiative for counting and interviewing homeless people in order to better understand and address the issue of homelessness in Berlin. Find more information about the [Zeit der Solidarität initiave](https://zeitdersolidaritaet.de/) on their website.

**Note that this repository and the fictional web app are in no way associated with the initiative. The initiave was merely taken as an inspiration for creating a web app that might help with such a counting process.**

## What exactly was built here?

Currently this repository is a one-person experiment that takes the (_assumed_) requirements of a web-based app for creating a more digitalized and streamlined counting process.

Some of the assumed requirements are:

- the web app needs to be able to record the [attributes that were recorded in the first Nacht der Solidarität counting](https://zeitdersolidaritaet.de/ergebnisse/) in Berlin in January 2020. Or at least partially for the sake of demonstration.
- the web app needs to have an authentication layer so that people can sign-up. Additionally there needs to be some form of authorization to distinguish between "regular" users and admins who organize and manage the countings.
- the results need to be machine-readable so that the analysis process is improved
- the web app needs to ensure that a good privacy protection is in place. No counted person should be tracable via this app.
- the app should support multiple languages

These requirements resulted in a prototypical app with the following functionalities:

- Administrators can organize Countings.
- Users can sign-up and add Countees to a Counting (only possible for the duration of a Counting)
- A Countee is always recorded at a certain geoposition (via placing a pin on a map in the UI). However the exact geoposition is never saved, only the Berlin district in which the Countee was encountered.
- Additionally, the following attributes can, but don't have to, be saved: age group, gender, number of pets. These attributes are a subset of the attributes recorded in the first Berlin counting in 2020.
- The aggregated results of a Counting are made available as a JSON API endpoint (e.g. `/de/countings/1/results/district.json` for an aggregation based on district)

> These are the most important features to mention for this prototype. More might follow in the future.

### Some screenshots of the app (currently only mobile-optimized)

...

## Technical notes

This app is a rather standard [Ruby on Rails](https://rubyonrails.org/) application (currently v7).

### Getting started

You will need to have Ruby v3 and Rails v7 installed to work on this project. In addition PostgreSQL is used as the database, so you will need to have a local PostgreSQL as well.

Make sure you have the correct Ruby version running by inspecting the `.ruby-version` file. A good tool for managing local Ruby versions is [rbenv](https://github.com/rbenv/rbenv).

Install the required gems via:

```bash
bundle install
```

Create and migrate a database:

```bash
bin/rails db:create && bin/rails db:migrate
```

Then start a development server via:

```bash
bin/dev
```

A development server should be available at [http://localhost:3000](http://localhost:3000).

### Testing

We use Rails' built-in `minitest` for testing. Its features cover all the use cases of this app. Conventionally find the tests in the `test/` folder.

#### Test coverage

Test coverage is tracked with [SimpleCov](https://github.com/simplecov-ruby/simplecov). Each test run generates a new coverage report at `coverage/index.html` (folder is gitignored). SimpleCov is configured in `test/test_helper.rb`. For now, no minimum coverage is required.

> Test coverage does not include system tests.

#### Running tests locally

Run all tests (except the slower system tests that boot up a real browser):

```bash
bin/rails test
```

#### Running tests locally with test coverage output

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

#### Running tests in CI

In the GitHub Action `.github/workflows/rubyonrails.yml`, we run all tests including the system tests with `bin/rails test:all`.

### More technical notes to follow

TBC

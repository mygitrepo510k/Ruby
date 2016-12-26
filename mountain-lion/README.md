HyeDating.com
============

## Development requirements:

- Ruby 2.0.0
- Rails 4.0.0
- Postgresql

## Dev Setup

    bundle install
    rake db:create
    rake db:schema:load
    rake db:test:prepare

## Runing tests
- MiniTest::Spec
- FactoryGirl
- Capybara

This project is set up with MiniTest::Spec and uses guard as an automatic test runner so just running `guard` should be enough, guard also takes care of your bundler and runs spork


### TODO:
Add a initializer script for creating initial data for development

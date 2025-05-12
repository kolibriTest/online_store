source "https://rubygems.org"

gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "image_processing", "~> 1.2"
gem "devise"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'sassc', '~> 2.4'
gem 'rack-cors'
gem 'bootstrap', '~> 5.2'

# ActiveAdmin
gem "activeadmin"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false

  # RSpec and Rswag
  gem "rspec-rails"
  gem "rswag"

  # RuboCop
  gem "rubocop-rails-omakase", require: false
  gem "rubocop", "~> 1.75.4", require: false
  gem "rubocop-rails", "~> 2.15", require: false

  gem "fasterer"
end

group :test do
  gem "simplecov", require: false
  gem "capybara"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console"
end

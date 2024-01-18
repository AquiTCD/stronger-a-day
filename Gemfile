source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby ["3.2.2", RUBY_VERSION].max

# === Core libraries
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.2" # by rails

# === Database, ORM, Model, etc
gem "attribute_normalizer"
gem "pg", "~> 1.1" # by rails Use postgresql as the database for Active Record
gem "redis", ">= 4.0.1" # by rails Use Redis adapter to run Action Cable in production
# gem "kredis" # by rails Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "bcrypt", "~> 3.1.7" # by rails Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]

# === Web servers
gem "puma", ">= 5.0" # by rails # Use the Puma web server [https://github.com/puma/puma]

# === CSS and JS
gem "importmap-rails" # by rails Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "propshaft" # by rails The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "stimulus-rails" # by rails Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "tailwindcss-rails" # by rails Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "turbo-rails" # by rails Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]

# === Authentication and Authorization
gem "devise"
# gem "omniauth-facebook"
# gem "omniauth-google-oauth2"
# gem "omniauth-steam"
gem "omniauth-rails_csrf_protection"
gem "omniauth-twitter2"

# === Views
# gem "draper"
# gem "kaminari"
gem "jbuilder" # by rails Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "slim-rails"

# === Others
gem "bootsnap", require: false # by rails Reduces boot times through caching; required in config/boot.rb
# gem "chrono_logger"
gem "config"
gem "enum_help"
# gem "image_processing", "~> 1.2" # by rails Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "interactor-rails"
gem "seed-fu"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "brakeman", require: false
  gem "bullet"
  gem "bundler-audit"
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console" # by rails Use console on exceptions pages [https://github.com/rails/web-console]
  # gem "rack-mini-profiler" # by rails Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "spring" # by rails Speed up commands on slow machines / big apps [https://github.com/rails/spring]

  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener_web"
  gem "rubocop", require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  gem "rspec_junit_formatter", require: false
  gem "rspec-rails"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby] # by rails

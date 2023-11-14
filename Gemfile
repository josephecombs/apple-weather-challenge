source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

gem 'rails', '~> 6.1.7', '>= 6.1.7.6'
gem 'puma', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Add this line for HTTP requests
gem 'httparty'
gem 'awesome_print'

# Add this line for geocoding (converting addresses to coordinates)
gem 'geocoder'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Add these lines for testing
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :test do
  # Add these lines for test utilities
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rails-controller-testing'
  gem 'timecop'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  # Add this line for better errors in development
  gem 'better_errors'
  gem 'binding_of_caller'
end

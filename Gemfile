# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake'
gem 'puma'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'

gem 'i18n'
gem 'config'

gem 'pg'
gem 'sequel'

gem 'dry-initializer'
gem 'dry-validation'

gem 'activesupport', require: false
gem 'fast_jsonapi'

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
end

group :test, :development do
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-rescue'
end

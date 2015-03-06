source 'https://rubygems.org'

ruby '2.2.1'

gem 'bundler', '>= 1.7.0'

gem 'rake'

gem 'rails', '~> 4.2'
gem 'sqlite3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'turbolinks'

gem 'devise'
gem 'haml'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'kaminari'
gem 'foreman'
gem 'elasticsearch-extensions'
gem 'chewy', github: 'toptal/chewy', ref: '0848878' # until 0.6.3 or later released

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-select'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'byebug'
  gem 'awesome_print', require: 'ap'
  gem 'meta_request'
  gem 'bullet'
  gem 'pry-rails'
end

group :development do
  gem 'rubocop'
end

group :test do
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-html'
  gem 'codeclimate-test-reporter', require: false
end

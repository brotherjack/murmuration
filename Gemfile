source 'https://rubygems.org'

gem 'activerecord'
gem 'activesupport'
gem 'aasm'
gem 'openssl'
gem 'pg'
gem 'rake'
gem 'net-ssh'

group :development do
  gem 'irb'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'factory_bot'
  gem 'faker',
      git: 'git@github.com:faker-ruby/faker.git',
      ref: '1c1b56178cf6aabddfdaffcf879bbf94b2725812'
end

group :test do
  gem 'shoulda', '~> 4.0'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'm', '~> 1.5.0'
end

#group :server do
#  gem 'sinatra'
#end

# coding: utf-8
require "minitest/autorun"
require 'minitest/unit'
require "minitest/reporters"
require "shoulda/matchers"
require 'shoulda/context'
require 'factory_bot'
require 'faker'
require 'shoulda'
require 'active_support/all'
require 'net/ssh'

require './lib/murmuration'

ENV['RACK_ENV'] = 'test'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :active_record
    with.library :active_model
  end
end

class Minitest::Unit::TestCase
  include FactoryBot::Syntax::Methods
end

FactoryBot.find_definitions

#Minitest::Reporters.use! Minitest::Reporters::RubyMateReporter.new

Murmuration::Config::DB.connect_to_db

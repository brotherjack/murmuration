require 'rake/testtask'
require "bundler/gem_tasks"
require 'active_record'
require './lib/murmuration'

namespace :db do
  db_params = {
    database: 'postgres',
    schema_search_path: 'public',
    adapter: 'postgresql',
    host: 'localhost',
    username: ENV.fetch('BIRB_USER'),
    password: ENV.fetch('BIRB_WORD'),
  }

  desc 'Migrate the database'
  task :migrate do
    version = ENV.fetch('MIGRATION_VERSION', Murmuration::Config::DB.latest_version_in_dir)
    Murmuration::Config::DB.connect_to_db
    puts "Migrating to version: #{version}"
    Murmuration::Config::DB.migrate_database version
    Rake::Task["db:schema"].invoke
    puts "Database successfully migrated."
  end

  desc 'Create the database'
  task :create do
    Murmuration::Config::DB.connect_to_admin_db
    Murmuration::Config::DB.create_database
    puts 'Database successfully created.'
  end

  desc 'Drop the database'
  task :drop do
    Murmuration::Config::DB.connect_to_admin_db
    Murmuration::Config::DB.drop_database
    puts 'Database successfully dropped.'
  end

  desc 'Reset the database'
  task reset: %i[drop create migrate]

  desc 'Create a DB schema that is portable on any DB supported by Active Record'
  task :schema do
    Murmuration::Config::DB.connect_to_db
    Murmuration::Config::DB.write_schema 'db/schema.rb'
    puts 'Database schema placed into db/schema.rb'
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration
  def self.change
  end
end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end

namespace :test do
  desc 'run all tests'
  Rake::TestTask.new(:all) do |t| 
    #t.libs.concat Dir['./factories/**/*_factory.rb']
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
end

namespace :pry do
  desc 'load murmuration into irb'
  task :run do
    require 'active_support/all'
    require 'net/ssh'
    require 'active_record'
    require 'factory_bot'
    require 'faker'
    require 'pry-byebug'
    require 'net/ssh'
    Dir['./lib/**/*.rb'].each { |file| require file }
    Dir['./factories/**/*_factory.rb'].each { |file| require file }
    FactoryBot.find_definitions
    Murmuration::Config::DB.connect_to_db
    pry
  end
end

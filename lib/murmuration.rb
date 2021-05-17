require 'active_record'
require 'pry-byebug'
#require 'active_record/schema_dumper'

module Murmuration
  module Config    
    class DB < ActiveRecord::Base
      class << self
        def check_for_new_migrations
          latest_in_dir > latest_on_db
        end
        
        def connect_to_admin_db
          ActiveRecord::Base.establish_connection admin_db_config
        end
        
        def connect_to_db
          ActiveRecord::Base.establish_connection db_config
        end
        
        def create_database
          begin
            connection.create_database database
          rescue ActiveRecord::ConnectionNotEstablished
            puts 'You have not connected to any database.'
            puts 'You need to run `Murmuration::Config::DB.connect_to_admin_db` first'
          end
        end
        
        def database
          @database = "#{ENV.fetch('database', 'murmuration')}_#{ENV.fetch('MUR_ENV', 'development')}"
        end
        
        def drop_database
          begin
            connection.drop_database database
          rescue ActiveRecord::ConnectionNotEstablished
            raise "You have not connected to the database, run 
`Murmuration::Config::DB.connect_to_admin_db` first".gsub("\n", '')
          end
        end
        
        def latest_migration_file
          latest = latest_version_in_dir.to_s
          Dir['./db/migrate/*'].find do |filename|
            filename.split('/').last.start_with? latest
          end
        end
        
        # Returns the latest version number in database
        def latest_version_in_db
          connect_to_admin_db.
            connection.
            schema_migration.
            last.
            version.
            to_i
        end
        
        # Returns the latest version number in migration directory by filename prefix
        def latest_version_in_dir
          Dir['./db/migrate/*'].
            map{ |f| f.split('/').last.split('_').first.to_i }.
            max
        end
        
        def migrate_database(version)
          begin
            connection.migration_context.migrate version
          rescue ActiveRecord::ConnectionNotEstablished
            raise "You have not connected to the database, run 
`Murmuration::Config::DB.connect_to_db` first".gsub("\n", '')
          end
          #ActiveRecord::MigrationContext.
          #  new('db/migrate/', connection.schema_migration).
          #  migrate
          #ActiveRecord::Migrator.migrate migrations_paths
        end
        
        def write_schema(filename)
          File.open(filename, "w:utf-8") do |file|
            ActiveRecord::SchemaDumper.dump(connection, file)
          end
        end
        
        private
        
        def admin_db_config
          db_config.merge({schema_search_path: 'public', database: 'postgres'})
        end
        
        def db_config
          @db_vals ||= YAML::load(File.open('config/database.yml'))
          {
            adapter: @db_vals.fetch('adapter', ''),
            host: @db_vals.fetch('host', ''),
            username: ENV.fetch(@db_vals.fetch('username_var', ''), ''),
            password: ENV.fetch(@db_vals.fetch('password_var', ''), ''),
            database: database,
          }
        end
      end
    end
  end
end

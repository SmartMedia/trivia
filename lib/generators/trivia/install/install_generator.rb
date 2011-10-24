require 'rails/generators'
require 'rails/generators/active_record'

module Trivia
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Generates trivia modesl and migrations'

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(path)
        ActiveRecord::Generators::Base.next_migration_number(path)
      end

      def generate_migration
        migration_template 'db/migrate/create_trivia_tables.rb', 'db/migrate/create_trivia_tables.rb'
      end

      def generate_models
        ['answer.rb', 'chosen_answer.rb', 'question.rb'].map { |f| "app/models/#{f}" }.each { |f| template f, f }
      end

      def add_acts_as_trivia_user
        say "Please add 'acts_as_trivia_user' to your User model", :green
      end
    end
  end
end

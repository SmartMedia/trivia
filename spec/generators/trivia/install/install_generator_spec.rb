require 'spec_helper'
require 'action_controller'
require 'generator_spec/test_case'

require 'generators/trivia/install/install_generator'

describe Trivia::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path('../../../../../tmp', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  specify do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'answer.rb' do
            contains 'class Answer'
            contains 'Trivia::Answer'
          end

          file 'chosen_answer.rb' do
            contains 'class ChosenAnswer'
            contains 'Trivia::ChosenAnswer'
            contains 'after_save :process_answer'
            contains 'def process_answer'
          end

          file 'question.rb' do
            contains 'class Question'
            contains 'Trivia::Question'
          end
        end
      end
      directory 'db' do
        directory 'migrate' do
          migration 'create_trivia_tables' do
            contains 'class CreateTriviaTables'
            contains 'create_table :answers'
            contains 'create_table :chosen_answers'
            contains 'create_table :questions'
          end
        end
      end
    }
  end
end

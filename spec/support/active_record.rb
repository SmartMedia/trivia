ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string :name
  end

  create_table :chosen_answers, :force => true do |t|
    t.references :user
    t.references :answer
    t.references :question
    t.integer :points
  end

  create_table :answers, :force => true do |t|
    t.string :answer
    t.boolean :right, :default => false
    t.references :question
  end

  create_table :questions, :force => true do |t|
    t.string :question, :null => false
    t.integer :points, :default => 0, :null => false
    t.datetime :published_from
    t.datetime :published_to
  end
end

class User < ActiveRecord::Base
  acts_as_trivia_user
end

class ChosenAnswer < ActiveRecord::Base
  include Trivia::ChosenAnswer
end

class Answer < ActiveRecord::Base
  include Trivia::Answer
end

class Question < ActiveRecord::Base
  include Trivia::Question
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :questions, :force => true do |t|
    t.string :question, :null => false
    t.integer :points, :default => 0, :null => false
    t.datetime 'published_from'
    t.datetime 'published_to'
  end
end

class Question < ActiveRecord::Base
  include Trivia::Question
end

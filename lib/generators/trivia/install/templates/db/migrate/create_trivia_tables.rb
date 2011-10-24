class CreateTriviaTables < ActiveRecord::Migration
  def change
    create_table :chosen_answers, :force => true do |t|
      t.references :user
      t.references :answer
      t.references :question
      t.integer :points

      t.timestamps
    end
    add_index :chosen_answers, :user_id
    add_index :chosen_answers, :answer_id
    add_index :chosen_answers, :question_id

    create_table :answers, :force => true do |t|
      t.string :answer
      t.boolean :right, :default => false
      t.references :question

      t.timestamps
    end
    add_index :answers, :question_id

    create_table :questions, :force => true do |t|
      t.string :question, :null => false
      t.integer :points, :default => 0, :null => false
      t.datetime :published_from
      t.datetime :published_to

      t.timestamps
    end
  end
end

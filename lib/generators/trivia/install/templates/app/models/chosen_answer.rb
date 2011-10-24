class ChosenAnswer < ActiveRecord::Base
  include Trivia::ChosenAnswer

  after_save :process_answer

  def process_answer
    if self.answer.right?
      # Add points to user, etc.
      #
      # Reward models and DSL:
      # https://github.com/SmartMedia/treasure_hunt
    end
  end
end

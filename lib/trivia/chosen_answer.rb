module Trivia
  module ChosenAnswer
    extend ActiveSupport::Concern

    included do
      belongs_to :answer
      belongs_to :user
      belongs_to :question

      validates_associated :answer, :user
      validates_presence_of :answer, :user

      validates :question_id, :uniqueness => { :scope => :user_id }

      before_save :fill_points, :fill_question
    end

    module ClassMethods

    end

    module InstanceMethods
      def fill_points
        self.points = self.answer.right ? self.answer.question.points : 0 unless self.points
      end

      def fill_question
        self.question = self.answer.question
      end
    end
  end
end

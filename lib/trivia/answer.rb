module Trivia
  module Answer
    extend ActiveSupport::Concern

    included do
      belongs_to :question

      validates_presence_of :answer, :question
      validates_associated :question

      scope :right, where(arel_table[:right].eq(true))
    end

    module ClassMethods

    end

    module InstanceMethods

    end

  end
end

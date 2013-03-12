module Trivia
  module Answer
    extend ActiveSupport::Concern

    included do
      attr_accessible :answer, :right, :question, :question_id, :translations_attributes

      belongs_to :question

      validates_presence_of :answer, :question
      validates_associated :question

      scope :right, where(arel_table[:right].eq(true))

      Translation.class_eval do
        attr_accessible :locale, :value
      end
    end

    module ClassMethods

    end

    module InstanceMethods

    end

  end
end

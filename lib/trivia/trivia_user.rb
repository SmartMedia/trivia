module Trivia
  module TriviaUser

    def acts_as_trivia_user
      include Trivia::TriviaUser::Model
    end

    module Model
      extend ActiveSupport::Concern

      included do
        has_many :chosen_answers, :dependent => :destroy
        has_many :answers, :through => :chosen_answers
        has_many :questions, :through => :chosen_answers
      end

      module ClassMethods

      end

      module InstanceMethods

      end
    end
  end
end

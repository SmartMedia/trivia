module Trivia
  module Question
    extend ActiveSupport::Concern

    included do
      has_many :answers, :dependent => :destroy

      validates_presence_of :question
      validate :validate_published_to

      t = self.arel_table
      scope :active, lambda {where(t[:published_from].lt(Time.now.to_s(:db)).or(t[:published_from].eq(nil)))
                           .where(t[:published_to].gt(Time.now.to_s(:db)).or(t[:published_to].eq(nil)))}

      scope :inactive, lambda{where('published_to < ?', Time.now.to_s(:db))}
    end

    module ClassMethods

    end

    module InstanceMethods
      def validate_published_to
        if self.published_from && self.published_to
          errors.add(:published_to, 'is before published from') if self.published_to < self.published_from
        end
      end
    end

  end
end

require 'spec_helper'

describe Trivia::Question do
  before do
    Question.destroy_all
  end

  context "when creating question" do
    it "should validate question attribute" do
      question = Question.new
      question.valid?.should be_false
      question.errors.should include(:question)

      question.question= 'What is the Ultimate Answer to the Ultimate Question of Life?'
      question.valid?.should be_true
    end

    it "activity should depend on datetime range" do
      Question.active.count.should == 0

      # Inactive
      # Published from tomorrow
      Question.create(:question => 'Inactive', :published_from => Time.now + 1.day)
      Question.active.count.should == 0

      # Published until yesterday
      Question.create(:question => 'Inactive', :published_to => 1.day.ago)
      Question.active.count.should == 0

      # Active
      # Default is active
      Question.create(:question => 'Active')
      Question.active.count.should == 1

      # Published since yesterday
      Question.create(:question => 'Active', :published_from => 1.day.ago)
      Question.active.count.should == 2

      # Published until tomorrow
      Question.create(:question => 'Active', :published_to => Time.now + 1.day)
      Question.active.count.should == 3
    end

    it "should validate published_from to published_to range" do
      question = Question.new(:question => 'Is this the real life? Is this just fantasy?')
      question.valid?.should be_true

      # Possible combination
      question.published_from = DateTime.now
      question.published_to = DateTime.now + 1.day
      question.valid?.should be_true

      # Impossible combination, dates swapped
      question.published_from, question.published_to = question.published_to, question.published_from
      question.valid?.should be_false

      # Possible combination - one is nil
      question.published_from = nil
      question.valid?.should be_true

      # Possible combination - one is nil
      question.published_from, question.published_to = question.published_to, question.published_from
      question.valid?.should be_true
    end
  end
end

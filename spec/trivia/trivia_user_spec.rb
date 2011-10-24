require 'spec_helper'

describe Trivia::TriviaUser do
  before do
    User.destroy_all
    @jane = User.create(:name => 'Jane')
  end

  context "when answered something" do
    before do
      Question.destroy_all
      @question = Question.create(:question => 'Is the cake lie?', :points => 42)
      @yes = @question.answers.create(:answer => 'Yes', :right => true)
      @no = @question.answers.create(:answer => 'No', :right => false)
    end

    it "should have answer and question" do
      chosen = ChosenAnswer.new(:answer => @no)
      @jane.chosen_answers << chosen

      @jane.answers.should =~ [@no]
      @jane.questions.should =~ [@question]
    end
  end
end

require 'spec_helper'

describe Trivia::Answer do
  before do
    Question.destroy_all
    @question = Question.create(:question => 'What is the meaning of life?', :points => 10)
  end

  context "when creating answer" do
    it "should validate answer attribute and question" do
      answer = Answer.new
      answer.valid?.should be_false
      answer.errors.should include(:answer)

      answer.answer = 42
      answer.errors.should include(:question)
      answer.valid?.should be_false

      answer.question = @question
      answer.valid?.should be_true
    end

    it "should be wrong default" do
      answer = Answer.new
      answer.right.should be_false
    end

    it "should be in 'right' scope if right" do
      Answer.right.count.should == 0

      Answer.create(:question => @question, :answer => 'Your job')
      Answer.right.count.should == 0

      Answer.create(:question => @question, :answer => 42, :right => true)
      Answer.right.count.should == 1
    end
  end
end

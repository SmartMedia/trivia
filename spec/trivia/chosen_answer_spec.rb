require 'spec_helper'

describe Trivia::ChosenAnswer do
  before do
    User.delete_all
    Question.delete_all
    @joe = User.create(:name => 'Joe')
    @question = Question.create(:question => 'Is the cake lie?', :points => 42)
    @yes = Answer.create(:answer => 'Yes', :right => true, :question => @question)
    @no = Answer.create(:answer => 'No', :right => false, :question => @question)
  end

  context "when creating chosen answer" do
    before do
      ChosenAnswer.delete_all
    end

    it "should validate foreign keys" do
      chosen = ChosenAnswer.new
      chosen.valid?.should be_false
      chosen.errors.should include(:user)
      chosen.errors.should include(:answer)
      chosen.errors.size.should == 2

      chosen.user = @joe
      chosen.valid?.should be_false
      chosen.errors.should include(:answer)
      chosen.errors.size.should == 1

      chosen.answer = @yes
      chosen.valid?.should be_true
    end

    it "should not allow answering same question again" do
      first = ChosenAnswer.create(:user => @joe, :answer => @yes)
      first.valid?.should be_true

      # Same answer
      second = ChosenAnswer.create(:user => @joe, :answer => @yes)
      second.valid?.should be_false

      # Different answer
      third = ChosenAnswer.create(:user => @joe, :answer => @no)
      second.valid?.should be_false
    end

    it "should have same points as question if right" do
      chosen = ChosenAnswer.create(:user => @joe, :answer => @yes)
      chosen.points.should == 42
    end

    it "should have 0 points if wrong" do
      chosen = ChosenAnswer.create(:user => @joe, :answer => @no)
      chosen.new_record?.should be_false
      chosen.points.should == 0
    end

    it "should not change points if set when creating" do
      chosen = ChosenAnswer.create(:user => @joe, :answer => @yes, :points => 13)
      chosen.new_record?.should be_false
      chosen.points.should == 13
    end
  end
end

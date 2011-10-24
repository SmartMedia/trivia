require 'trivia/trivia_user'
ActiveRecord::Base.send :extend, Trivia::TriviaUser

require 'trivia/answer'
require 'trivia/chosen_answer'
require 'trivia/question'

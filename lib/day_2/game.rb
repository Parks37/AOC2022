require_relative 'shape'
require 'byebug'


module Day2

  class Rock < Shape
    value 1
    beats :scissors
    loses_to :paper
  end

  class Paper < Shape
    value 2
    beats :rock
    loses_to :scissors
  end

  class Scissors < Shape
    value 3
    beats :paper
    loses_to :rock
  end

  class Game

    def initialize(file)
      @file = file
    end

    def scores_for_shapes
      File.readlines(@file).map do |line|
        opponent, player = line.split(' ').map{|x| to_shape(x).new}
        player.send(opponent.name)
      end
    end

    def scores_for_outcomes
      File.readlines(@file).map do |line|
        opponent_letter, outcome_letter = line.split(' ')
        opponent = to_shape(opponent_letter).new
        outcome = to_outcome(outcome_letter)
        player_key = opponent.send(outcome)
        to_shape(player_key).new.send(opponent.name)
      end
    end

    private

    def to_shape(key)
      case key
      when 'A', 'X', :rock
        Rock
      when 'B', 'Y', :paper
        Paper
      when 'C', 'Z', :scissors
        Scissors
      end
    end

    def to_outcome(key)
      case key
      when 'X'
        :beats
      when 'Y'
        :ties
      when 'Z'
        :loses_to
      end
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

game = Day2::Game.new(from_file)

puts "The scores for the shapes are #{game.scores_for_shapes.sum}."

puts "The scores for the outcomes are #{game.scores_for_outcomes.sum}."



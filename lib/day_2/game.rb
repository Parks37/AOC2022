require_relative 'shape'
require 'byebug'


module Day2

  class Rock < Shape
  end

  class Paper < Shape
  end

  class Scissors < Shape
  end

  Rock.value(1)
  Rock.beats Scissors
  Rock.loses_to Paper

  Paper.value(2)
  Paper.beats Rock
  Paper.loses_to Scissors

  Scissors.value(3)
  Scissors.beats Paper
  Scissors.loses_to Rock

  Player = Struct.new(:key) do
    def shape
      case key
      when 'X'
        Rock.new
      when 'Y'
        Paper.new
      when 'Z'
        Scissors.new
      end
    end
  end

  Opponent = Struct.new(:key) do
    def shape
      case key
      when 'A'
        Rock.new
      when 'B'
        Paper.new
      when 'C'
        Scissors.new
      end
    end
  end

  Outcome = Struct.new(:key) do
    def to_symbol
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

  RoundInput = Struct.new(:file) do
    def to_a
      File.readlines(file).map do |line|
        line.split(' ')
      end
    end

    def outcomes(gameStruct)
      to_a.map do |keys|
        game_input = gameStruct.new(keys)
        Game.new(game_input.player, game_input.opponent)
      end
    end
  end

  Part1Game = Struct.new(:players) do
    def opponent
      Opponent.new(players.first).shape
    end

    def player
      Player.new(players.last).shape
    end
  end

  Part2Game = Struct.new(:keys) do
    def opponent
      Opponent.new(keys.first).shape
    end

    def player
      outcome = Outcome.new(keys.last)
      opponent.send(outcome.to_symbol)
    end
  end

  Game = Struct.new(:player, :opponent) do
    def score
      player.send(opponent.to_symbol)
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

round_input = Day2::RoundInput.new(from_file)

puts "Day2 Part 1: #{round_input.outcomes(Day2::Part1Game).map(&:score).sum}"

puts "Day2 Part 2: #{round_input.outcomes(Day2::Part2Game).map(&:score).sum}"




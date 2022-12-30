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

  class RoundInput
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def to_a
      File.readlines(file).map do |line|
        line.strip.split(' ')
      end
    end
  end

  class Opponent
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def to_shape
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

  class Player
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def to_shape
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

  class Outcome
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def to_s
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

  class Game
    attr_reader :player, :opponent

    def initialize(player, opponent)
      @player = player
      @opponent = opponent
    end

    def score
      player.send(opponent.to_symbol)
    end
  end

  class GameInput
    attr_reader :array

    def initialize(array)
      @array = array
    end

    def opponent
      Opponent.new(array[0]).to_shape
    end

    def player
      Player.new(array[1]).to_shape
    end

    def outcome
      Outcome.new(array[1]).to_s
    end
  end


end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

round_input = Day2::RoundInput.new(from_file)

scores = round_input.to_a.map do |game_input|
  game_input = Day2::GameInput.new(game_input)
  game = Day2::Game.new(game_input.player, game_input.opponent)
  game.score
end

puts scores.sum

scores = round_input.to_a.map do |game_input|
  game_input = Day2::GameInput.new(game_input)
  player = game_input.opponent.send(game_input.outcome)
  game = Day2::Game.new(player, game_input.opponent)
  game.score
end

puts scores.sum


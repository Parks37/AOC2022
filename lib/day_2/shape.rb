require 'byebug'

module Day2
  class Shape

    def self.value(value)
      define_method(:value) { value }
      define_method(:ties) { self.class.new }
      define_method(self.to_symbol) { value + 3 }
    end

    def self.beats(shape)
      define_method(:beats) { shape.new }
      define_method(shape.to_symbol) { value + 6 }
    end

    def self.loses_to(shape)
      define_method(:loses_to) { shape.new }
      define_method(shape.to_symbol) { value }
    end

    def self.to_symbol
      symbol = self.name.split('::').last.downcase.to_sym
      define_method(:to_symbol) { symbol }
      symbol
    end
  end
end

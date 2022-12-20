require 'byebug'

module Day2
  class Shape

    def initialize
      define_singleton_method(:ties) { name }
      define_singleton_method(name) { value + 3 }
    end

    def self.value(value)
      define_method(:value) { value }
    end

    def self.beats(name)
      define_method(:beats) { name }
      define_method(name) { value + 6 }
    end

    def self.loses_to(name)
      define_method(:loses_to) { name }
      define_method(name) { value }
    end

    def name
      self.class.name.split('::').last.downcase.to_sym
    end
  end
end

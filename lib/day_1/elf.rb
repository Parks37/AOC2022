module Day1
  class Elf
    attr_reader :food_items

    def initialize()
      @food_items = []
    end

    def add_food_item(calories)
      food_items << calories
    end

    def total_calories
      food_items.sum
    end

    def <=>(other)
      total_calories <=> other.total_calories
    end
  end
end

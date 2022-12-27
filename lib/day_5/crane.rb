require 'byebug'

module Day5
  class FSM
    attr_reader :state

    def initialize(file)
      @file = file
      @state = 0
    end

    def parse_file
      File.readlines(@file).each do |line|
        if line.strip == '' || (line.strip.match(/[A-z]/) == nil)
          @state += 1
        end
      end
    end

    def parse_line(line)
      case @state
      when 0
        load_stack(line)
      when 1
        load_queue(line)
      when 2
        load_stack(line)
      end
    end

    def load_stack(line)

    end
  end
end
module Day6

  class Marker
    attr_reader :letters, :marker_length

    def initialize(marker_length)
      @letters = []
      @marker_length = marker_length
    end

    def unique_letters
      letters.uniq || []
    end

    def valid?
      unique_letters.length == marker_length
    end

    def load_letter(letter)
      new_string = letters.push(letter)

      if new_string.length > marker_length
        @letters = new_string.drop(1)
      end
    end
  end

  Datastream = Struct.new(:input, :marker_length) do
    def start_of_packet_marker
      marker = Marker.new(marker_length)

      input.split('').each_with_index do |char, idx|
        marker.load_letter(char)
        if marker.valid?
          return idx + 1
          break
        end
      end
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

dummy_input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

puts "The start of the packet marker is at position #{Day6::Datastream.new(dummy_input, 4).start_of_packet_marker}. for the dummy_file when the marker_length is 4"

puts "The start of the packet marker is at position #{Day6::Datastream.new(File.read(from_file), 4).start_of_packet_marker} when the marker_length is 4."

puts "The start of the packet marker is at position #{Day6::Datastream.new(File.read(from_file), 14).start_of_packet_marker} when the marker_length is 14."
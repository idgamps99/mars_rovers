require_relative '../classes/rover'

RSpec.describe 'Rover' do
  let(:rover) { Rover.new(1, 2, "E")}

  def move
    calculate_next
    rover.move
    rover
  end

  context 'when initialised' do
    it 'has a x position' do
      expect(rover.x_position).to eq(1)
    end

    it 'has a y position' do
      expect(rover.y_position).to eq(2)
    end

    it 'has an orientation' do
      expect(rover.orientation).to eq("E")
    end
  end

  context 'when calculating next move' do
    def calculate(move)
    end

    it 'correctly calculates orienting left' do
      rover = Rover.new("3", "3", "N")
      rover.calculate_move("L")
      expect(rover.next_orientation).to eq("W")
    end

    it 'correctly calculates orienting right' do
      rover = Rover.new("3", "3", "N")
      rover.calculate_move("R")
      expect(rover.next_orientation).to eq("E")
    end

    it 'correctly calculates next x position' do
      rover = Rover.new("3", "3", "E")
      rover.calculate_move("M")
      expect(rover.next_x).to eq(4)
    end

    it 'correctly calculates next y position' do
      rover = Rover.new("3", "3", "S")
      rover.calculate_move("M")
      expect(rover.next_y).to eq(2)
    end
  end

  context 'when moving rover' do
    it 'correctly orients left' do
      rover = Rover.new("3", "3", "N")
      rover.calculate_move("L")
      rover.move
      expect(rover.orientation).to eq("W")
    end

    it 'correctly orients right' do
      rover = Rover.new("3", "3", "N")
      rover.calculate_move("R")
      rover.move
      expect(rover.orientation).to eq("E")
    end

    it 'correctly changes x position' do
      rover = Rover.new("3", "3", "E")
      rover.calculate_move("M")
      rover.move
      expect(rover.x_position).to eq(4)
    end

    it 'correctly changes x position' do
      rover = Rover.new("3", "3", "S")
      rover.calculate_move("M")
      rover.move
      expect(rover.y_position).to eq(2)
    end
  end
end

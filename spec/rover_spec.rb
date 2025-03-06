require_relative '../classes/rover'

RSpec.describe 'Rover' do
  let(:rover) { Rover.new(1, 2, "N")}

  def calculate_next
    rover.calculate_move("LMLMLMMLMMR")
    rover
  end

  def move
    calculate_next
    rover.move
    rover
  end
  it 'has a x position' do
    expect(rover.x_position).to eq(1)
  end

  it 'has a y position' do
    expect(rover.y_position).to eq(2)
  end

  it 'has an orientation' do
    expect(rover.orientation).to eq("N")
  end

  context 'when calculating move' do

    it 'correctly changes next x position' do
      expect(calculate_next.next_x).to eq(2)
    end

    it 'correctly changes next y position' do
      expect(calculate_next.next_y).to eq(3)
    end

    it 'correctly changes next orientation' do
      expect(calculate_next.next_orientation).to eq("E")
    end
  end

  context 'when moving rover' do
    it 'correctly changes x position' do
      expect(move.x_position).to eq(2)
    end

    it 'correctly changes x position' do
      expect(move.y_position).to eq(3)
    end

    it 'correctly changes orientation' do
      expect(move.orientation).to eq("E")
    end
  end
end

require_relative '../classes/rover'

RSpec.describe 'Rover' do
  let(:rover) { Rover.new(1, 2, "N")}

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
    def move_rover
      rover.calculate_move("LMLMLMMLMMR")
      rover
    end

    it 'correctly changes next x position' do
      expect(move_rover.next_x).to eq(2)
    end

    it 'correctly changes next y position' do
      expect(move_rover.next_y).to eq(3)
    end

    it 'correctly changes next orientation' do
      expect(move_rover.next_orientation).to eq("E")
    end

    # test for error checking here
  end
end

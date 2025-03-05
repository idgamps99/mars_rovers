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

  context 'when moved' do
    def move_rover
      rover.move("LMLMLMMLMMR")
      rover
    end

    it 'correctly changes x position' do
      expect(move_rover.x_position).to eq(2)
    end

    it 'correctly changes y position' do
      expect(move_rover.y_position).to eq(3)
    end

    it 'correctly changes orientation' do
      expect(move_rover.orientation).to eq("E")
    end

    # test for error checking here
  end
end

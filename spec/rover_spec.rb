require_relative '../rover'

RSpec.describe 'Rover' do
  let(:rover) { Rover.new(1, 2, "N")}

  it 'has a x position' do
    expect(rover.x_position).to eq(1)
  end

  it 'has a y position' do
    expect(rover.y_position).to eq(2)
  end

  it 'must have an orientation' do
    expect(rover.orientation).to eq("N")
  end

  context 'when instructed to move' do
    # before{ rover.move("LMLMLMMLMM") }

    it 'correctly changes x position' do
      expect(rover.x_position).to eq(2)
    end

    it 'correctly changes y position' do
      expect(rover.y_position).to eq(3)
    end

    it 'correctly changes orientation' do
      expect(rover.position).to eq("N")
    end
  end
end

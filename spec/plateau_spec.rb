require_relative '../plateau'

RSpec.describe 'Plateau' do
  let(:plateau) { Plateau.new(5, 5) }

  context 'top right coordinates' do
    it 'has x coordinate' do
      expect(plateau.x_coordinate).to eq(5)
    end

    it 'has y coordinate' do
      expect(plateau.y_coordinate).to eq(5)
    end

    it 'cannot change x coordinate' do
      expect{ plateau.x_coordinate = 6 }.to raise_error(NoMethodError)
    end

    it 'cannot change y coordinate' do
      expect{ plateau.y_coordinate = 6 }.to raise_error(NoMethodError)
    end
  end

  context 'grid' do
    it 'exists' do
      expect(plateau).to respond_to(:grid)
    end

    it 'is a hash' do
      expect(plateau.grid.class).to eq(Hash)
    end

    it 'keys are coordinates' do
      expect(plateau.grid.key?([1, 4])).to eq(true)
    end

    it 'has the correct number of coordinates' do
      expect(plateau.grid.keys.count).to eq(36)
    end

    it 'upper bound equals x coordinate' do
      expect(plateau.grid[[plateau.x_coordinate + 1, plateau.y_coordinate]]).to eq(nil)
    end

    it 'upper bound equals y coordinate' do
      expect(plateau.grid[[plateau.x_coordinate, plateau.y_coordinate + 1]]).to eq(nil)
    end

    it 'coordinates initialise as empty' do
      expect(plateau.grid.values.all?(false)).to eq(true)
    end
  end

  context 'valid_move?' do
    context 'accepts' do
      it 'accepts valid coordinates' do
        expect(plateau.valid_move?([2, 2])).to eq(true)
      end
    end

    context 'rejects' do
      it 'string coordinates' do
        expect(plateau.valid_move?(["1", "3"])).to eq(false)
      end

      it 'invalid coordinate format' do
        expect{ plateau.valid_move?(2, 2) }.to raise_error(ArgumentError)
      end

      it 'incomplete coordinates' do
        expect(plateau.valid_move?([2])).to eq(false)
      end

      it 'invalid coordinate container (non array)' do
        expect(plateau.valid_move?(1)).to eq(false)
      end

      it 'occupied coordinate' do
        plateau.grid[[1, 2]] = true
        expect(plateau.valid_move?([1, 2])).to eq(false)
      end
    end
  end

  context 'tracking' do
    before do
      plateau.track([1, 1], [1, 2])
    end

    it 'occupies new coordinate' do
      expect(plateau.grid[[1, 1]]).to eq(true)
    end

    it 'unoccupies old coordinate' do
      expect(plateau.grid[[1, 2]]).to eq(false)
    end
  end
end

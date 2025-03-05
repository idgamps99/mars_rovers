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

    it 'has the correct number of coordinates' do
      expect(plateau.grid.keys.count).to eq(36)
    end
  end
end

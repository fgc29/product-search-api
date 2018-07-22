require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#search' do
    let!(:jetsetter_jeans) { create(:product, name: 'jetsetter jeans') }
    let!(:travel_jeans) { create(:product, name: 'travel jeans') }
    let!(:fireside_flannels) { create(:product, name: 'fireside flannels') }
    let!(:washed_chinos) { create(:product, name: 'washed chinos') }

    context 'returns washed chinos' do
      it 'returns product when washed chinos is the search term' do
        expect(Product.search('washed chinos')).to eq(washed_chinos)
      end

      it 'returns product when wish is the search term' do
        expect(Product.search('wish')).to eq(washed_chinos)
      end

      it 'returns product when wash is the search term' do
        expect(Product.search('wash')).to eq(washed_chinos)
      end

      it 'returns product when washed chimp is the search term' do
        expect(Product.search('washed chimp')).to eq(washed_chinos)
      end

      it 'returns product when w is the search term' do
        expect(Product.search('washed chimp')).to eq(washed_chinos)
      end
    end

    context 'returns travel jeans' do
      it 'returns product when travel jeans is the search term' do
        expect(Product.search('travel jeans')).to eq(travel_jeans)
      end

      it 'returns product when travel is the search term' do
        expect(Product.search('travel')).to eq(travel_jeans)
      end

      it 'returns product when travels is the search term' do
        expect(Product.search('travels')).to eq(travel_jeans)
      end
    end

    context 'returns nil' do
      it 'returns nil when zzzz is the search term' do
        expect(Product.search('zzzz')).to be_nil
      end
    end
  end
end
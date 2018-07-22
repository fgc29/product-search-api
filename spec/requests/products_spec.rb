require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:inventory) { [2,56,75,90,67,14,92] }
  let!(:total_inventory) { inventory.reduce(:+) }
  let!(:washed_chino) do
    chinos = create(:product, name: 'washed chinos')

    inventory.each do |inventory_count|
      create(:inventory, product: chinos, count: inventory_count)
    end
    chinos
  end
  let!(:travel_jeans) { create(:product, name: 'travel jeans') }
  let(:inventories) do
    washed_chino.inventories.map do |inventory|
      {
          "id"     => inventory.id,
          "waist"  => inventory.waist,
          "length" => inventory.length,
          "style"  => inventory.style,
          "count"  => inventory.count
      }
    end
  end
  let(:washed_chino_json) do
    {
        "description" => washed_chino.description,
        "image" =>  washed_chino.image,
        "inventories" => inventories,
        "name" => washed_chino.name,
        "total_inventory" => total_inventory
    }
  end

  describe 'GET /api/products/search' do
    context 'with proper search term' do
      before { get '/api/products/search?product=washed' }

      it 'returns product' do
        json = JSON.parse(response.body)
        expect(json).to eq(washed_chino_json)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid search term' do
      before { get '/api/products/search?product=zzz' }

      it 'returns product' do
        json = JSON.parse(response.body)
        expect(json).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with empty search term' do
      before { get '/api/products/search?product=' }

      it 'returns product' do
        json = JSON.parse(response.body)
        expect(json).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
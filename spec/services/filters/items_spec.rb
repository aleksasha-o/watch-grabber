# frozen_string_literal: true

describe Filters::Items do
  describe '#filter' do
    subject { described_class.new(params: params).filter }

    let!(:item1) { create(:item, brand: 'Rolex', model: 'Datejust', price: '10') }
    let!(:item2) { create(:item, brand: 'Autodromo', model: 'Datejust', price: '20') }
    let!(:item3) { create(:item, brand: 'Cartier', price: '5') }

    context 'with one correct search params' do
      let(:params) { { model: 'Datejust' } }

      it { expect(subject).to match_array([item1, item2]) }
    end

    context 'with two correct search params' do
      let(:params) { { brands: ['Autodromo'], model: 'Datejust' } }

      it { expect(subject).to eq([item2]) }
    end

    context 'with wrong search params' do
      let(:params) { { model: 'Wrong' } }

      it { expect(subject).not_to include(item1, item2) }
    end

    context 'without search params' do
      let(:params) { {} }

      it { expect(subject).to match_array([item1, item2, item3]) }
    end

    context 'sort ascending by brand' do
      let(:params) { { sort: 'brandASC' } }

      it { expect(subject).to eq([item2, item3, item1]) }
    end

    context 'sort descending by brand' do
      let(:params) { { sort: 'brandDESC' } }

      it { expect(subject).to eq([item1, item3, item2]) }
    end

    context 'sort ascending by price' do
      let(:params) { { sort: 'priceASC' } }

      it { expect(subject).to eq([item3, item1, item2]) }
    end

    context 'sort descending by price' do
      let(:params) { { sort: 'priceDESC' } }

      it { expect(subject).to eq([item2, item1, item3]) }
    end
  end
end

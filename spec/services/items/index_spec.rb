# frozen_string_literal: true

describe Items::Index do

  subject { described_class.new(params: params) }

  let!(:item1) { create(:item, brand: 'Rolex', model: 'Datejust', price: '10') }
  let!(:item2) { create(:item, brand: 'Autodromo', price: '20') }
  let!(:item3) { create(:item, brand: 'Cartier', price: '5') }
  let(:params) { {} }

  describe '#items' do
    context 'without params' do
      before { allow(Filters::Items).to receive(:filter).and_return([item1, item2, item3]) }

      it { expect(subject.items).to match_array([item1, item2, item3]) }
    end

    context 'with params' do
      before { allow(Filters::Items).to receive(:filter).and_return(item1) }

      it { expect(subject.items).to eq(item1) }
    end
  end

  it { expect(subject.brands_for_select).to match_array(%w[Autodromo Cartier Rolex]) }
  it { expect(subject.default_min_price).to eq(5) }
  it { expect(subject.default_max_price).to eq(20) }
end

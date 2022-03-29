# frozen_string_literal: true

describe ItemsController, type: :controller do
  describe '#index' do
    subject { get :index }

    let!(:items)  { create_list(:item, rand(4..7)) }
    let(:expected_list) { items.sort_by(&:brand) }

    before { subject }

    it { expect(assigns(:items)).to eq(expected_list) }
  end
end

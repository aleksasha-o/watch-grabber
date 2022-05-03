# frozen_string_literal: true

describe ItemsController, type: :controller do
  describe '#index' do
    subject { get :index }

    before do
      allow(Items::Index).to receive(:new).and_return({ controller: 'items', action: 'index' })
      subject
    end

    it { expect(assigns(:data)).to eq({ controller: 'items', action: 'index' }) }
  end
end

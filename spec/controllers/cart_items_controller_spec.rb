# frozen_string_literal: true

describe CartItemsController, type: :controller do
  before { sign_in current_user }

  let(:current_user) { create(:user) }
  let(:current_item) { create(:item) }

  describe '#index' do
    subject { get :index }

    before do
      allow(CartItems::Index).to receive(:new).and_return({ controller: 'cart_items', action: 'index' })
      subject
    end

    it { expect(assigns(:data)).to eq({ controller: 'cart_items', action: 'index' }) }
  end

  describe '#create with correct params' do
    subject { post :create, params: { item_id: current_item.id, user_id: current_user.id } }

    it { expect { subject }.to change(CartItem, :count).by(1) }

    context 'after create' do
      before { subject }

      it { expect(controller).to set_flash[:notice].to(I18n.t('cart.add')) }
      it { is_expected.to redirect_to(items_path) }
    end
  end

  describe '#create with wrong params' do
    subject { post :create, params: { item_id: current_item.id + 1, user_id: current_user.id + 1 } }

    it { expect { subject }.not_to change(CartItem, :count) }

    context 'after create' do
      before { subject }

      it { expect(controller).to set_flash[:alert].to(I18n.t('error')) }
      it { is_expected.to redirect_to(items_path) }
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: current_item.id } }

    before { create(:cart_item, user_id: current_user.id, item_id: current_item.id) }

    it { expect { subject }.to change(CartItem, :count).by(-1) }

    context 'after destroy' do
      before { subject }

      it { expect(controller).to set_flash[:notice].to(I18n.t('cart.delete')) }
      it { is_expected.to redirect_to(cart_items_path) }
    end
  end
end

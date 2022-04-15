# frozen_string_literal: true

describe Admin::ProcessorsController, type: :controller do
  describe '#create' do
    subject { post :create }

    before { subject }

    it { expect(controller).to set_flash[:notice].to(I18n.t('processors.start')) }
    it { is_expected.to redirect_to(admin_processors_path) }
  end

  describe '#destroy' do
    subject { post :destroy }

    before { subject }

    it { expect(controller).to set_flash[:notice].to(I18n.t('processors.stop')) }
    it { is_expected.to redirect_to(admin_processors_path) }
  end
end

# frozen_string_literal: true

describe Admins::ProcessorsController, type: :controller do
  describe '#create' do
    subject { post :create }

    before do
      sign_in create(:admin)
      subject
    end

    it { expect(controller).to set_flash[:notice].to(I18n.t('processors.start')) }
    it { is_expected.to redirect_to(admins_processors_path) }
  end

  describe '#destroy' do
    subject { post :destroy }

    before do
      sign_in create(:admin)
      subject
    end

    it { expect(controller).to set_flash[:notice].to(I18n.t('processors.stop')) }
    it { is_expected.to redirect_to(admins_processors_path) }
  end
end

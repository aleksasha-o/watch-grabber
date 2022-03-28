# frozen_string_literal: true

describe Admin::ProcessorsController, type: :controller do
  describe '#create' do

    subject { post :create, params: { item: params } }

    before do
      allow_any_instance_of(Ferrum::Browser).to receive(:go_to)
      allow_any_instance_of(Ferrum::Browser).to receive(:at_css).and_return(true)
    end

    let(:params) do
      {
        type:        %w[HodinkeeItem CrownandcaliberItem BobswatchesItem].sample,
        price:       Faker::Commerce.price(range: 0..100_000.0, as_string: true),
        currency:    %w[usd eur uah].sample,
        external_id: Faker::Internet.uuid
      }
    end

    it { expect(subject).to redirect_to(admin_processors_path) }

    it 'sets flash message' do
      subject
      expect(controller).to set_flash[:notice].to(I18n.t('processors.success'))
    end
  end
end

# frozen_string_literal: true

describe Admin::ProcessorsController, type: :controller do
  describe '#create' do
    subject { post :create }

    let(:hodinkee_file) { file_fixture('shophodinkee_first_page.html').read }
    let(:crown_file) { file_fixture('crownandcaliber_first_page.html').read }
    let(:bobs_file) { file_fixture('bobswatches_first_page.html').read }

    let(:hodinkee_url) { 'https://shop.hodinkee.com/collections/watches?page=18' }
    let(:crown_url) { 'https://www.crownandcaliber.com/collections/shop-for-watches?page=54' }
    let(:bobs_url) { 'https://www.bobswatches.com/shop?page=21' }

    before do
      allow_any_instance_of(Browser).to receive(:visit)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: hodinkee_url,
              tag: Processors::ShopHodinkeeProcessor::PAGE)
        .and_return(hodinkee_file)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: crown_url,
              tag: Processors::CrownandcaliberProcessor::PAGE)
        .and_return(crown_file)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: bobs_url,
              tag: Processors::BobswatchesProcessor::PAGE)
        .and_return(bobs_file)
    end

    describe 'with correct pages' do
      let(:hodinkee_item_file) { file_fixture('shophodinkee_item_page.html').read }
      let(:hodinkee_created_item) { HodinkeeItem.find_by(model: 'Prospex SLA043 Limited Edition') }

      let(:crown_item_file) { file_fixture('crownandcaliber_item_page.html').read }
      let(:crown_created_item) { CrownandcaliberItem.find_by(model: 'Datejust') }

      let(:bobs_item_file) { file_fixture('bobswatches_item_page.html').read }
      let(:bobs_created_item) { BobswatchesItem.find_by(model: 'Sky-Dweller 326934') }

      before do
        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://shop.hodinkee.com/collections/watches/products/aquaracer-200-blue-dial-on-bracelet',
                tag: '.vendor')
          .and_return(hodinkee_item_file)

        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5',
                tag: '.vendor')
          .and_return(crown_item_file)

        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://www.bobswatches.com/mens-rolex-gmt-master-ii-116710blnr.html',
                tag: '.price')
          .and_return(bobs_item_file)
      end

      it 'creates items with needed params' do
        subject
        expect(hodinkee_created_item).to have_attributes(dial_color:       'Blue',
                                                         crystal:          'Sapphire crystal',
                                                         water_resistance: '200 meters',
                                                         manufactured:     'Japan')

        expect(crown_created_item).to have_attributes(papers:    'Yes',
                                                      box:       'No',
                                                      gender:    'Men',
                                                      condition: 'Very Good')

        expect(bobs_created_item).to have_attributes(year:          '2021',
                                                     gender:        "Men's",
                                                     condition:     'Excellent',
                                                     regular_price: '$30,350.36')
      end

      it { expect { subject }.to change(Item, :count).by(3) }

      it { expect(subject).to redirect_to(admin_processors_path) }

      it 'sets flash message' do
        subject
        expect(controller).to set_flash[:notice].to(I18n.t('processors.success'))
      end
    end

    describe 'with wrong pages' do
      it { expect { subject }.not_to change(Item, :count) }
    end
  end
end

# frozen_string_literal: true

describe HodinkeeJob, redis: true do
  let(:hodinkee_file) { file_fixture('shophodinkee_first_page.html').read }
  let(:hodinkee_url) { 'https://shop.hodinkee.com/collections/watches?page=1' }
  let(:redis) { MockRedis.new }
  let(:run) { double(blank?: false) }

  before do
    allow(Redis).to receive(:current).and_return(redis)
    allow(redis).to receive(:get).and_return(run)

    allow_any_instance_of(Browser).to receive(:visit)

    allow_any_instance_of(Browser)
      .to receive(:visit)
      .with(url: hodinkee_url,
            tag: Processors::ShopHodinkeeProcessor::PAGE)
      .and_return(hodinkee_file)
  end

  describe 'with correct page' do
    subject { described_class.new.perform }

    let(:hodinkee_item_file) { file_fixture('shophodinkee_item_page.html').read }
    let(:hodinkee_created_item) { HodinkeeItem.find_by(model: 'Prospex SLA043 Limited Edition') }

    before do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://shop.hodinkee.com/collections/watches/products/bamford-x-peanuts-joe-preppy-gmt-limited-edition-for-hodinkee',
              tag: '.section-title')
        .and_return(hodinkee_item_file)
    end

    context 'after call method' do
      before { subject }

      it 'creates items with needed params' do
        expect(hodinkee_created_item).to have_attributes(dial_color:       'Blue',
                                                         crystal:          'Sapphire crystal',
                                                         water_resistance: '200 meters',
                                                         manufactured:     'Japan')
      end
    end

    it { expect { subject }.to change(Item, :count).by(1) }
  end

  it { is_expected.to be_processed_in :parsing }
  it { is_expected.to be_retryable true }
end

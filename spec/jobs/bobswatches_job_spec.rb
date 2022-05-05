# frozen_string_literal: true

describe BobswatchesJob do
  include_context 'with Redis'

  let(:bobs_file) { file_fixture('bobswatches_first_page.html').read }
  let(:bobs_url) { 'https://www.bobswatches.com/shop?page=1' }

  before do
    redis.set('parsing:run', true)

    allow_any_instance_of(Browser).to receive(:visit)

    allow_any_instance_of(Browser)
      .to receive(:visit)
      .with(url: bobs_url,
            tag: Processors::BobswatchesProcessor::PAGE)
      .and_return(bobs_file)
  end

  describe 'with correct page' do
    subject { described_class.new.perform }

    let(:bobs_item_file) { file_fixture('bobswatches_item_page.html').read }
    let(:bobs_created_item) { BobswatchesItem.find_by(model: 'Sky-Dweller 326934') }

    before do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.bobswatches.com/mens-rolex-gmt-master-ii-116710blnr.html',
              tag: '.price')
        .and_return(bobs_item_file)
    end

    context 'after call method' do
      before { subject }

      it 'creates items with needed params' do
        expect(bobs_created_item).to have_attributes(year:          '2021',
                                                     gender:        "Men's",
                                                     condition:     'Excellent',
                                                     regular_price: '$30,350.36')
      end
    end

    it { expect { subject }.to change(Item, :count).by(1) }
  end

  it { is_expected.to be_processed_in :parsing }
  it { is_expected.to be_retryable true }
end

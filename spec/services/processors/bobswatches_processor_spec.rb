# frozen_string_literal: true

describe Processors::BobswatchesProcessor, redis: true do
  describe '#call' do
    let(:file) { file_fixture('bobswatches_first_page.html').read }
    let(:item_file) { file_fixture('bobswatches_item_page.html').read }
    let(:created_item) { BobswatchesItem.find_by(model: 'Sky-Dweller 326934') }

    let(:redis) { MockRedis.new }
    let(:run) { double(blank?: false) }

    before do
      allow(Redis).to receive(:current).and_return(redis)
      allow(redis).to receive(:get).and_return(run)

      allow_any_instance_of(Browser).to receive(:visit)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.bobswatches.com/shop?page=1', tag: '.product-title')
        .and_return(file)
    end

    context 'on correct page' do
      before do
        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://www.bobswatches.com/mens-rolex-gmt-master-ii-116710blnr.html',
                tag: '.price')
          .and_return(item_file)

        subject.call
      end

      it {
        expect(created_item).to have_attributes(year:          '2021',
                                                gender:        "Men's",
                                                condition:     'Excellent',
                                                regular_price: '$30,350.36')
      }
    end

    context 'on wrong page' do
      before do
        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://www.bobswatches.com/shop?page=1',
                tag: '.price')
          .and_return(file)

        subject.call
      end

      it { expect(created_item).to be_nil }
    end
  end
end

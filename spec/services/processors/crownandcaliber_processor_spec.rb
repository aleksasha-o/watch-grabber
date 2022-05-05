# frozen_string_literal: true

describe Processors::CrownandcaliberProcessor do
  include_context 'with Redis'

  describe '#call' do
    let(:file) { file_fixture('crownandcaliber_first_page.html').read }
    let(:item_file) { file_fixture('crownandcaliber_item_page.html').read }
    let(:created_item) { CrownandcaliberItem.find_by(model: 'Datejust') }

    before do
      redis.set('parsing:run', true)

      allow_any_instance_of(Browser).to receive(:visit)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.crownandcaliber.com/collections/shop-for-watches?page=1',
              tag: '.card-title.ng-binding')
        .and_return(file)
    end

    context 'on correct page' do
      before do
        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5',
                tag: '.vendor')
          .and_return(item_file)

        subject.call
      end

      it {
        expect(created_item).to have_attributes(model:          'Datejust',
                                                papers:         'Yes',
                                                box:            'No',
                                                gender:         'Men',
                                                condition:      'Very Good',
                                                bezel_material: 'Stainless Steel',
                                                manual:         'No')
      }
    end

    context 'on wrong page' do
      before do
        allow_any_instance_of(Browser)
          .to receive(:visit)
          .with(url: 'https://www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5',
                tag: '.vendor')
          .and_return(file)

        subject.call
      end

      it { expect(created_item).to be_nil }
    end
  end
end

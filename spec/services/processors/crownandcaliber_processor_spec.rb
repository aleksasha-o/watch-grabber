# frozen_string_literal: true

describe Processors::CrownandcaliberProcessor do
  describe '#call' do
    let(:file) { file_fixture('crownandcaliber_first_page.html').read }
    let(:item_file) { file_fixture('crownandcaliber_item_page.html').read }
    let(:created_item) { CrownandcaliberItem.find_by(model: 'Datejust') }

    before do
      allow_any_instance_of(Browser).to receive(:visit)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.crownandcaliber.com/collections/shop-for-watches?page=1', tag: '.card-title.ng-binding')
        .and_return(file)
    end

    it 'works' do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5',
              tag: '.vendor')
        .and_return(item_file)

      subject.call
      expect(created_item).to have_attributes(model:          'Datejust',
                                              papers:         'Yes',
                                              box:            'No',
                                              gender:         'Men',
                                              condition:      'Very Good',
                                              bezel_material: 'Stainless Steel',
                                              manual:         'No')
    end

    it 'does not work with wrong page' do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5',
              tag: '.vendor')
        .and_return(file)

      subject.call
      expect(created_item).to be_nil
    end
  end
end

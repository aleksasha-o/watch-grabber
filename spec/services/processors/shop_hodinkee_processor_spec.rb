# frozen_string_literal: true

describe Processors::ShopHodinkeeProcessor do
  describe '#call' do
    let(:file) { file_fixture('shophodinkee_first_page.html').read }
    let(:item_file) { file_fixture('shophodinkee_item_page.html').read }
    let(:created_item) { HodinkeeItem.find_by(model: 'Prospex SLA043 Limited Edition') }

    before do
      allow_any_instance_of(Browser).to receive(:visit)

      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://shop.hodinkee.com/collections/watches?page=1', tag: '.product-title')
        .and_return(file)
    end

    it 'works' do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://shop.hodinkee.com/collections/watches/products/aquaracer-200-blue-dial-on-bracelet',
              tag: '.vendor')
        .and_return(item_file)

      subject.call
      expect(created_item).to have_attributes(dial_color:        'Blue',
                                              case_material:     'Stainless steel with black hard coating',
                                              case_dimensions:   '39.9mm diameter; 14.1mm thickness',
                                              bracelet_material: 'Black silicone strap',
                                              movement_type:     'Seiko, self-winding, 8L35',
                                              crystal:           'Sapphire crystal',
                                              water_resistance:  '200 meters',
                                              reference_number:  'SLA043',
                                              functions:         'Hours, minutes, seconds, date',
                                              caseback:          'Stainless steel',
                                              power_reserve:     '50 hours',
                                              manufactured:      'Japan',
                                              lume:              'Yes, LumiBrite')
    end

    it 'does not work with wrong page' do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://shop.hodinkee.com/collections/watches/products/aquaracer-200-blue-dial-on-bracelet',
              tag: '.vendor')
        .and_return(file)

      subject.call
      expect(created_item).to be_nil
    end
  end
end

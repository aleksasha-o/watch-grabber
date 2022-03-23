# frozen_string_literal: true

describe Parsers::CrownandcaliberParser do
  subject { described_class.new(file) }

  describe 'on item page' do
    let(:file) { file_fixture('crownandcaliber_item_page.html').read }
    let(:additional_attributes) do
      {
        papers:         'Yes',
        box:            'No',
        year:           '2013',
        gender:         'Men',
        crystal:        'Sapphire',
        condition:      'Very Good',
        caseback:       'Solid',
        power_reserve:  '48 hours',
        lug_width:      '20.0',
        bezel_material: 'Stainless Steel',
        manual:         'No',
        max_wrist_size: '6.5 inches',
        case_thickness: '12.0 mm'
      }
    end
    let(:base_attributes) do
      {
        brand:             'Rolex',
        model:             'Datejust',
        price:             '7350',
        currency:          'usd',
        dial_color:        'White',
        case_material:     'Stainless Steel',
        case_dimensions:   '36.00',
        bracelet_material: 'Stainless Steel',
        movement_type:     'Automatic'
      }
    end

    describe '#additional_attributes' do
      it { expect(subject.additional_attributes).to eq(additional_attributes) }
    end

    describe '#base_attributes' do
      it { expect(subject.base_attributes).to eq(base_attributes) }
    end

    describe '#attributes' do
      it { expect(subject.attributes).to eq(base_attributes.merge!(additional_attributes)) }
    end
  end

  describe 'on page with items list' do
    let(:file) { file_fixture('crownandcaliber_first_page.html').read }

    describe '#item_urls' do
      let(:links) do
        %w[//www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5
           //www.crownandcaliber.com/products/omega-speedmaster-324-30-38-50-03-002-10-10-ome-7ab80n
           //www.crownandcaliber.com/products/rolex-datejust-116200-10-10-rol-6fa5l3]
      end

      it { expect(subject.item_urls).to match_array(links) }
    end

    describe '#next_page?' do
      it { expect(subject.next_page?).to be(true) }

      describe 'when next page does not exist' do
        let(:file) { file_fixture('crownandcaliber_last_page.html').read }

        it { expect(subject.next_page?).to be(false) }
      end
    end
  end
end

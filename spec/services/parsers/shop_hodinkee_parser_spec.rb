# frozen_string_literal: true

describe Parsers::ShopHodinkeeParser do
  subject { described_class.new(file) }

  describe 'on item page' do
    let(:file) { file_fixture('shophodinkee_item_page.html').read }
    let(:additional_attributes) do
      {
        crystal:          'Sapphire crystal',
        water_resistance: '200 meters',
        reference_number: 'SLA043',
        functions:        'Hours, minutes, seconds, date',
        caseback:         'Stainless steel',
        power_reserve:    '50 hours',
        lug_width:        nil,
        manufactured:     'Japan',
        lume:             'Yes, LumiBrite'
      }
    end
    let(:base_attributes) do
      {
        brand:             'Seiko',
        model:             'Prospex SLA043 Limited Edition',
        price:             '4500',
        currency:          'usd',
        dial_color:        'Blue',
        case_material:     'Stainless steel with black hard coating',
        case_dimensions:   '39.9mm diameter; 14.1mm thickness',
        bracelet_material: 'Black silicone strap',
        movement_type:     'Seiko, self-winding, 8L35'
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
    let(:file) { file_fixture('shophodinkee_first_page.html').read }

    describe '#item_urls' do
      let(:links) do
        %w[/collections/watches/products/aquaracer-200-blue-dial-on-bracelet
           /collections/watches/products/seiko-prospex-alpinist-limited-edition-sje085
           /collections/watches/products/sbga467-deposit]
      end

      it { expect(subject.item_urls).to match_array(links) }
    end

    describe '#next_page?' do
      it { expect(subject.next_page?).to be(true) }

      describe 'when next page does not exist' do
        let(:file) { file_fixture('shophodinkee_last_page.html').read }

        it { expect(subject.next_page?).to be(false) }
      end
    end
  end
end

# frozen_string_literal: true

describe Parsers::BobswatchesParser do
  subject { described_class.new(file) }

  describe 'on item page' do
    let(:file) { file_fixture('bobswatches_item_page.html').read }
    let(:additional_attributes) do
      {
        box_and_papers: 'Rolex box, booklets, hang tag, wallet and Rolex warranty card dated 06/2021',
        year:           '2021',
        gender:         "Men's",
        condition:      'Excellent',
        regular_price:  '$30,350.36'
      }
    end
    let(:dial) do
      'Black w/ Chromalight display w/ date, month, GMT, second time zone, hour minute and second hand, ' \
        '24 hour display in off center disc, Month display via 12 apertures around the circumference of the dial'
    end
    let(:case_material) do
      '904L stainless steel (42mm) w/ 18k white gold Fluted rotatable ring command bezel, screw down case back,' \
        ' dual time zone, inner reflector ring engraved with serial number and scratch resistant sapphire crystal'
    end

    let(:base_attributes) do
      {
        brand:             'Rolex',
        model:             'Sky-Dweller 326934',
        price:             '29495',
        currency:          'usd',
        dial_color:        dial,
        case_material:     case_material,
        case_dimensions:   '42mm',
        bracelet_material: '904L stainless steel Oyster w/ Oysterclasp',
        movement_type:     'Automatic 9001',
        external_id:       '148270 x',
        image_uri:         'https://www.bobswatches.com/images/Rolex-Sky-Dweller-326934-148270.png'
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
    let(:file) { file_fixture('bobswatches_first_page.html').read }

    describe '#item_urls' do
      let(:links) do
        %w[/mens-rolex-gmt-master-ii-116710blnr.html
           /rolex-datejust-41-ref-126334-black-diamond-dial.html
           /pre-owned-rolex-datejust-41-ref-126334-dark-rhodium-dial.html
           /rolex-submariner-16613-champagne-serti.html]
      end

      it { expect(subject.item_urls).to match_array(links) }
    end

    describe '#next_page?' do
      it { expect(subject.next_page?).to be(true) }

      describe 'when next page does not exist' do
        let(:file) { file_fixture('bobswatches_last_page.html').read }

        it { expect(subject.next_page?).to be(false) }
      end
    end
  end
end

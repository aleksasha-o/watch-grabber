# frozen_string_literal: true

describe Item, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }

    describe 'unique external_id' do
      subject { build(:item) }

      it { is_expected.to validate_uniqueness_of(:external_id) }
    end
  end

  describe 'scopes' do
    let!(:item1) do
      create(:item,
             brand:             'test1 brand',
             model:             'test1 model',
             price:             '200',
             dial_color:        'test1 dial_color',
             case_material:     'test1 case_material',
             case_dimensions:   'test1 case_dimensions',
             bracelet_material: 'test1 bracelet_material',
             movement_type:     'test1 movement_type')
    end
    let!(:item2) do
      create(:item,
             brand:           'test1 brand',
             model:           'test1 model',
             price:           '300',
             case_dimensions: 'test1 case_dimensions')
    end

    context 'with right search params' do
      it { expect(described_class.by_brands(%w[test1 brand])).to match_array([item1, item2]) }
      it { expect(described_class.by_model('test1 model')).to match_array([item1, item2]) }
      it { expect(described_class.by_price(min_price: 100, max_price: 500)).to match_array([item1, item2]) }
      it { expect(described_class.by_dial_color('test1 dial_color')).to match_array([item1]) }
      it { expect(described_class.by_case_material('test1 case_material')).to match_array([item1]) }
      it { expect(described_class.by_case_dimensions('test1 case_dimensions')).to match_array([item1, item2]) }
      it { expect(described_class.by_bracelet_material('test1 bracelet_material')).to match_array([item1]) }
      it { expect(described_class.by_movement_type('test1 movement_type')).to match_array([item1]) }
    end

    context 'with wrong search params' do
      it {
        expect(described_class.by_brands(%w[Search Find Nothing])
                              .by_model('Wrong')
                              .by_price(min_price: 100, max_price: 200)
                              .by_dial_color('Wrong')
                              .by_case_material('Wrong')
                              .by_case_dimensions('Wrong')
                              .by_bracelet_material('Wrong')
                              .by_movement_type('Wrong'))
          .not_to include(item1, item2)
      }
    end

    context 'with empty search params' do
      it { expect(described_class.by_model(nil)).to match_array([item1, item2]) }
      it { expect(described_class.by_model('   ')).to match_array([item1, item2]) }
    end

    context 'sorting' do
      it { expect(described_class.ordered_by_brand_asc).to eq(described_class.order(brand: :asc)) }
      it { expect(described_class.ordered_by_brand_desc).to eq(described_class.order(brand: :desc)) }
      it { expect(described_class.ordered_by_price_asc).to eq(described_class.order(price: :asc)) }
      it { expect(described_class.ordered_by_price_desc).to eq(described_class.order(price: :desc)) }
    end
  end
end

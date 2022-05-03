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

    describe 'scopes' do
      let!(:item1) do
        create(:item,
               brand:             'Autodromo',
               model:             'Datejust',
               price:             '1000',
               dial_color:        'Black',
               case_material:     'Steel',
               case_dimensions:   '41',
               bracelet_material: 'Leather',
               movement_type:     'Automatic')
      end
      let!(:item2) do
        create(:item,
               brand:           'Autodromo',
               model:           'Datejust',
               price:           '500',
               case_dimensions: '41')
      end

      context 'with right search params' do
        it { expect(described_class.by_brands(%w[Autodromo])).to eq([item1, item2]) }
        it { expect(described_class.by_model('Datejust')).to eq([item1, item2]) }
        it { expect(described_class.by_price(min_price: 100, max_price: 2000)).to eq([item1, item2]) }
        it { expect(described_class.by_dial_color('Black')).to eq([item1]) }
        it { expect(described_class.by_case_material('Steel')).to eq([item1]) }
        it { expect(described_class.by_case_dimensions('41')).to eq([item1, item2]) }
        it { expect(described_class.by_bracelet_material('Leather')).to eq([item1]) }
        it { expect(described_class.by_movement_type('Automatic')).to eq([item1]) }
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
        it { expect(described_class.by_model(nil)).to eq([item1, item2]) }
        it { expect(described_class.by_model('   ')).to eq([item1, item2]) }
      end

      context 'sorting' do
        it { expect(described_class.ordered_by_brand_asc).to eq(described_class.order(brand: :asc)) }
        it { expect(described_class.ordered_by_brand_desc).to eq(described_class.order(brand: :desc)) }
        it { expect(described_class.ordered_by_price_asc).to eq(described_class.order(price: :asc)) }
        it { expect(described_class.ordered_by_price_desc).to eq(described_class.order(price: :desc)) }
      end
    end
  end
end

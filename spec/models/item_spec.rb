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
end

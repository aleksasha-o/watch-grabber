# frozen_string_literal: true

describe HodinkeeItem, type: :model do
  describe 'validations' do
    it 'validates :crystal length' do
      is_expected
        .to validate_length_of(:crystal)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :water_resistance length' do
      is_expected
        .to validate_length_of(:water_resistance)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :reference_number length' do
      is_expected
        .to validate_length_of(:reference_number)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :functions length' do
      is_expected
        .to validate_length_of(:functions)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :caseback length' do
      is_expected
        .to validate_length_of(:caseback)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :power_reserve length' do
      is_expected
        .to validate_length_of(:power_reserve)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :manufactured length' do
      is_expected
        .to validate_length_of(:manufactured)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :lug_width length' do
      is_expected
        .to validate_length_of(:lug_width)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :lume length' do
      is_expected
        .to validate_length_of(:lume)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it { is_expected.to allow_value('', nil).for(:crystal) }
    it { is_expected.to allow_value('', nil).for(:water_resistance) }
    it { is_expected.to allow_value('', nil).for(:reference_number) }
    it { is_expected.to allow_value('', nil).for(:functions) }
    it { is_expected.to allow_value('', nil).for(:caseback) }
    it { is_expected.to allow_value('', nil).for(:power_reserve) }
    it { is_expected.to allow_value('', nil).for(:manufactured) }
    it { is_expected.to allow_value('', nil).for(:lug_width) }
    it { is_expected.to allow_value('', nil).for(:lume) }
  end
end

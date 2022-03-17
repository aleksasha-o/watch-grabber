# frozen_string_literal: true

require 'rails_helper'

describe CrownandcaliberItem, type: :model do
  describe 'validations' do
    it 'validates :papers length' do
      is_expected
        .to validate_length_of(:papers)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :box length' do
      is_expected
        .to validate_length_of(:box)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :year length' do
      is_expected
        .to validate_length_of(:year)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :gender length' do
      is_expected
        .to validate_length_of(:gender)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :crystal length' do
      is_expected
        .to validate_length_of(:crystal)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :condition length' do
      is_expected
        .to validate_length_of(:condition)
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

    it 'validates :lug_width length' do
      is_expected
        .to validate_length_of(:lug_width)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :bezel_material length' do
      is_expected
        .to validate_length_of(:bezel_material)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :manual length' do
      is_expected
        .to validate_length_of(:manual)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :max_wrist_size length' do
      is_expected
        .to validate_length_of(:max_wrist_size)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :case_thickness length' do
      is_expected
        .to validate_length_of(:case_thickness)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it { is_expected.to allow_value('', nil).for(:papers) }
    it { is_expected.to allow_value('', nil).for(:box) }
    it { is_expected.to allow_value('', nil).for(:year) }
    it { is_expected.to allow_value('', nil).for(:gender) }
    it { is_expected.to allow_value('', nil).for(:crystal) }
    it { is_expected.to allow_value('', nil).for(:condition) }
    it { is_expected.to allow_value('', nil).for(:caseback) }
    it { is_expected.to allow_value('', nil).for(:power_reserve) }
    it { is_expected.to allow_value('', nil).for(:lug_width) }
    it { is_expected.to allow_value('', nil).for(:bezel_material) }
    it { is_expected.to allow_value('', nil).for(:manual) }
    it { is_expected.to allow_value('', nil).for(:max_wrist_size) }
    it { is_expected.to allow_value('', nil).for(:case_thickness) }
  end
end

# frozen_string_literal: true

describe BobswatchesItem, type: :model do
  describe 'validations' do
    it 'validates :box_and_papers length' do
      is_expected
        .to validate_length_of(:box_and_papers)
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

    it 'validates :condition length' do
      is_expected
        .to validate_length_of(:condition)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it 'validates :regular_price length' do
      is_expected
        .to validate_length_of(:regular_price)
        .is_at_least(described_class::MIN_FEATURE_LENGTH)
    end

    it { is_expected.to allow_value('', nil).for(:box_and_papers) }
    it { is_expected.to allow_value('', nil).for(:year) }
    it { is_expected.to allow_value('', nil).for(:gender) }
    it { is_expected.to allow_value('', nil).for(:condition) }
    it { is_expected.to allow_value('', nil).for(:regular_price) }
  end
end

# frozen_string_literal: true

RSpec.describe Item, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:price) }
    it { expect(subject).to validate_numericality_of(:price).is_greater_than(0) }

    context 'validates :currency if :price is presence' do
      before { allow(subject).to receive(:price).and_return(true) }

      it { is_expected.to validate_presence_of(:currency) }
    end

    context 'validates :currency if :price is not presence' do
      before { allow(subject).to receive(:price).and_return(false) }

      it { is_expected.not_to validate_presence_of(:currency) }
    end
  end
end

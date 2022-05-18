# frozen_string_literal: true

describe CartItems::Index do
  subject { described_class.new(current_user) }

  let(:current_user) { create(:user) }
  let!(:items) { create_list(:item, 6) }
  let(:item_ids) { items.map(&:id) }

  it '#items_in_cart' do
    3.times do
      item_id = items.map(&:id).sample
      create(:cart_item, user_id: current_user.id, item_id: item_id)
      item_ids.delete(item_id)
    end

    expect(subject.items_in_cart).to match_array(Item.joins(:cart_items))
  end

  it { expect(subject.total_in_cart).to eq(Item.joins(:cart_items).sum(&:price)) }
end

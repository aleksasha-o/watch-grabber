# frozen_string_literal: true

describe CrownandcaliberJob do
  let(:crown_file) { file_fixture('crownandcaliber_first_page.html').read }
  let(:crown_url) { 'https://www.crownandcaliber.com/collections/shop-for-watches?page=1' }

  before do
    allow_any_instance_of(Browser).to receive(:visit)

    allow_any_instance_of(Browser)
      .to receive(:visit)
      .with(url: crown_url,
            tag: Processors::CrownandcaliberProcessor::PAGE)
      .and_return(crown_file)
  end

  describe 'with correct page' do
    subject { described_class.new.perform }

    let(:crown_item_file) { file_fixture('crownandcaliber_item_page.html').read }
    let(:crown_created_item) { CrownandcaliberItem.find_by(model: 'Datejust') }

    before do
      allow_any_instance_of(Browser)
        .to receive(:visit)
        .with(url: 'https://www.crownandcaliber.com/products/rolex-datejust-126334-10-10-rol-altzu5',
              tag: '.vendor')
        .and_return(crown_item_file)
    end

    context 'after call method' do
      before { subject }

      it 'creates items with needed params' do
        expect(crown_created_item).to have_attributes(papers:    'Yes',
                                                      box:       'No',
                                                      gender:    'Men',
                                                      condition: 'Very Good')
      end
    end

    it { expect { subject }.to change(Item, :count).by(1) }
  end

  it { is_expected.to be_processed_in :parsing }
  it { is_expected.to be_retryable true }
end

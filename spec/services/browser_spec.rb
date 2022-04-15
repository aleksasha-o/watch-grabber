# frozen_string_literal: true

describe Browser do
  describe '#visit' do
    subject do
      described_class.new.visit(
        url: Processors::ShopHodinkeeProcessor::HOST,
        tag: Processors::ShopHodinkeeProcessor::PAGE
      )
    end

    let(:html) { file_fixture('shophodinkee_first_page.html').read }
    let(:expected_title) { 'New Watches - HODINKEE Shop' }

    before do
      allow_any_instance_of(Ferrum::Browser).to receive(:go_to)
      allow_any_instance_of(Ferrum::Browser).to receive(:at_css).and_return(true)
    end

    it 'returns html body of requested page' do
      allow_any_instance_of(Ferrum::Frame).to receive(:body).and_return(html)

      expect(subject).to include(expected_title)
    end

    describe 'Ferrum browser setup' do
      let(:network) { double(intercept: true) }

      before do
        allow_any_instance_of(Ferrum::Browser).to receive(:network).and_return(network)
        allow(network).to receive(:clear).with(:traffic).and_return(true)
        allow(network).to receive(:clear).with(:cache).and_return(true)
      end

      after { subject }

      it { expect_any_instance_of(Ferrum::Browser).to receive(:on).with(:request) }
      it { expect(network).to receive(:intercept) }
      it { expect(network).to receive(:clear).with(:traffic) }
      it { expect(network).to receive(:clear).with(:cache) }
    end
  end

  describe '#exit_browser' do
    after { subject.exit_browser }

    it { expect_any_instance_of(Ferrum::Browser).to receive(:quit) }
  end
end

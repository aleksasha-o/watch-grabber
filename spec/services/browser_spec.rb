# frozen_string_literal: true

describe Browser do
  describe '#visit' do
    subject do
      described_class.new.visit(
        url: 'https://shop.hodinkee.com/collections/watches?page=1',
        tag: '.product-title'
      )
    end

    let(:html) { file_fixture('shophodinkee_first_page.html').read }

    before do
      allow_any_instance_of(Ferrum::Browser).to receive(:go_to)
      allow_any_instance_of(Ferrum::Browser).to receive(:at_css).and_return(true)
    end

    it 'returns html body of requested page' do
      allow_any_instance_of(Ferrum::Frame).to receive(:body).and_return(html)

      expect(subject).to include('New Watches - HODINKEE Shop')
    end

    describe 'Ferrum browser setup' do
      let(:network) { double }

      before { allow_any_instance_of(Ferrum::Browser).to receive(:network).and_return(network) }

      it 'works' do
        expect_any_instance_of(Ferrum::Browser).to receive(:on).with(:request)
        expect(network).to receive(:intercept)

        subject
      end
    end
  end

  describe '#exit_browser' do
    it 'works' do
      expect_any_instance_of(Ferrum::Browser).to receive(:quit)
      subject.exit_browser
    end
  end
end

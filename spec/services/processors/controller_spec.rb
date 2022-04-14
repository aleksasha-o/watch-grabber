# frozen_string_literal: true

describe Processors::Controller do
  let(:redis) { MockRedis.new }

  before do
    allow(Redis).to receive(:current).and_return(redis)
  end

  describe '#run' do
    before do
      allow(HodinkeeJob).to receive(:perform_async).and_return(true)
      allow(CrownandcaliberJob).to receive(:perform_async).and_return(true)
      allow(BobswatchesJob).to receive(:perform_async).and_return(true)

      subject.run
    end

    it 'set correct value for parsing:run in Redis' do
      expect(redis.get('parsing:run')).to eq('true')
    end

    it 'set correct value for parsing:run:datetime in Redis' do
      freeze_time do
        expect(redis.get('parsing:run:datetime')).to eq(Time.zone.now.to_formatted_s(:short))
      end
    end
  end

  describe '#stop' do
    before do
      subject.stop
    end

    it 'set correct value for parsing:run in Redis' do
      expect(redis.get('parsing:run')).to eq(nil)
    end

    it 'set correct value for parsing:stop:datetime in Redis' do
      freeze_time do
        expect(redis.get('parsing:stop:datetime')).to eq(Time.zone.now.to_formatted_s(:short))
      end
    end
  end

  describe '#check' do
    before do
      redis.set('parsing:run', true)

      allow(Sidekiq::Queue).to receive(:all).and_return(find_mock)

      subject.check
    end

    context 'without jobs' do
      let(:find_mock) { double(find: []) }

      it { expect(redis.get('parsing:run')).to eq(nil) }
    end

    context 'with jobs' do
      let(:find_mock) { double(find: ['imaginary_job']) }

      it { expect(redis.get('parsing:run')).to eq('true') }
    end
  end
end

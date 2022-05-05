# frozen_string_literal: true

shared_context 'with Redis' do
  let(:redis) { Redis.current }

  before { redis.flushdb }
end

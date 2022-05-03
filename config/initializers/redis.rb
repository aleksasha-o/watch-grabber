# frozen_string_literal: true

fallback = Rails.env.test? ? 'redis://localhost:6379/2' : 'redis://localhost:6379/1'
Redis.current = Redis.new(url: ENV['REDIS_URL'] || fallback)

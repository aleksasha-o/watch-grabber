# frozen_string_literal: true

fallback = if ENV['REDIS_URL'].present?
             ENV['REDIS_URL']
           else
             Rails.env.test? ? 'redis://localhost:6379/2' : 'redis://localhost:6379/1'
           end
Redis.current = Redis.new(url: fallback)

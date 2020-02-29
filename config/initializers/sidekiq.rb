url_redis = if Rails.env.development? || Rails.env.test?
               'redis'
             else
               ''
             end

redis_conn = proc {
  Redis.new(host: url_redis)
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

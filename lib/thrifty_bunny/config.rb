require 'bunny'

module ThriftyBunny
  class Config
    attr_reader :host, :port, :vhost, :user, :password, :ssl, :queue, :exchange

    def initialize(options={})
      @host = options[:host] || '127.0.0.1'
      @port = options[:port] || 5672

      @vhost = options[:vhost] || "/"
      @user = options[:user] || "guest"
      @password = options[:password] || "guest"
      @ssl = options[:ssl] || false

      @queue = options[:queue] || 'rpc_queue'
      @exchange = options[:exchange] || 'rpc_exchange'
    end

    def bunny_config
      { 
        host: host, port: port, vhost: vhost,
        user: user, password: password, ssl: ssl
      }
    end

  end
end
require 'bunny'

module Publishers
  class Application
    # key arguments w google, zobacz sobie sposob zapisu
    def initialize(message:, exchange_name:, routing_key:)
      @message = message
      @exchange_name = exchange_name
      @routing_key = routing_key
    end

    def perform
      connection.start
      channel = connection.create_channel
      channel.direct(@exchange_name).publish(@message.to_json, routing_key: @routing_key)
      connection.close
    end

    private

    def connection_options
      {
        host: A9n.bunny_host,
        port: A9n.bunny_port,
        vhost: A9n.bunny_vhost,
        username: A9n.bunny_username,
        password: A9n.bunny_password
      }
    end

    def connection
      @connection ||= Bunny.new(connection_options)
    end
  end
end

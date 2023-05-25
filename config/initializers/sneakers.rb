require 'sneakers'

bunny_connection_options = { host: "localhost", port: "5672", vhost: "/", username: "guest", password: "guest" }

Sneakers.configure(
  connection: Bunny.new(bunny_connection_options),
  durable: false,
  workers: 1
)

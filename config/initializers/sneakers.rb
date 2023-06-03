require 'sneakers'

bunny_connection_options = { host: A9n.bunny_host, port: A9n.bunny_port,
 vhost: A9n.bunny_vhost, username: A9n.bunny_username,
  password: A9n.bunny_password }

Sneakers.configure(
  connection: Bunny.new(bunny_connection_options),
  durable: false,
  workers: 1
)

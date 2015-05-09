# Thrifty::Bunny

A RabbitMQ-ApacheThrift adapter for RPC calls

## Acknowledgements

This gem is largely-based on the [Stephen Henrie's Apache Thrift AMQP](https://github.com/shenrie/apache-thrift-amqp). Thanks to Stephen for his work and excellent tutorial.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thrifty-bunny'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thrifty-bunny

## Usage

The gem provides a Thrift server that integrates with RabbitMQ. You would use this server in standard Thrift fashion:

```ruby
handler = MyHandler.new
processor = MyProcessor.new(handler)
service = ThriftyBunny::RpcServer.new(processor)
service.serve(log_messages: true)
```

Then you would utilize the included ```ClientTransport``` to connect your Thrift client to RabbitMQ:

```ruby
transport = ThriftyBunny::ClientTransport.new
protocol = Thrift::BinaryProtocol.new(transport)
client = MyService::Client.new(protocol)
client.my_remote_method() # Make the remote procedure call
```

### Configuration

Both the ```RpcServer``` and the ```ClientTransport``` accept a ```ThriftyBunny::Config``` object that encapsulates the RabbitMQ configuration settings. The default values for the configuration options are:

    option        | default      | notes
    ------------- | ------------ | -------------------------------------
    host          | 127.0.0.1    | Host name or IP for the RabbitMQ host
    port          | 5672         | Port that RabbitMQ is listening on
    vhost         | /            | Virtual host path
    user          | guest        | RabbitMQ user
    password      | guest        | RabbitMQ password
    queue         | rpc_queue    | Name of RabbitMQ queue for the RPC messages
    exchange      | rpc_exchange | Name of the RabbitMQ exchange for the RPC messages
    timeout       | 10           | Timeout (in seconds)
    log           | true         | Log debugging messages to stdout

## Specs

The specs can be run individually or via a `bundle exec rake spec`. The integration specs require RabbitMQ to be running on the localhost on port 5672. The integration specs will launch the example server, and then exercise the client calls, and the stop the example server.

## Examples

An easy way to experiment with the gem is to take a look at the provided examples. There is an example simple client and server. To run the example:

1. Start up RabbitMQ -- it should be running on the default port (5672) with the default credentials.

2. Start up two separate terminals

3. In one terminal, start the server:
    ```
    $ bundle exec examples/calculator/server.start
    ```

5. In the other terminal, start the client:
    ```
    $ bundle exec examples/calculator/client.start
    ```

6. In the [RabbitMQ admin console](http://localhost:15672), you can monitor the message queues.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/thrifty-bunny/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

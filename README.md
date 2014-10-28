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


## Examples

An easy way to experiment with the gem is to take a look at the provided examples. There is an example simple client and server. To run the example:

1. Start up RabbitMQ -- it should be running on the default port (5672) with the default credentials.

2. Start up two separate terminals

3. Change to the ```examples``` directory in each terminal:
    ```
    $ cd examples
    ```

4. In one terminal, start the server:
    ```
    $ bundle exec bin/server.start
    ```

5. In the other terminal, start the client:
    ```
    $ bundle exec bin/client.start
    ```

6. In the [RabbitMQ admin console](http://localhost:15672), you can monitor the message queues.

The client prompts you to enter a name, then the servers respond by saying hello to you. Feel free to start up additional servers to demonstrate how the system scales. 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/thrifty-bunny/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

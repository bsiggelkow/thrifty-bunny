$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../examples", __FILE__)

require 'bundler'
Bundler.setup(:default, :test)

require 'thrifty_bunny'
#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'

require_relative 'helper'
require_relative 'alarm'
require_relative 'socket_listener'

class Perhoa
  CONFIG_FILE = ENV['HOME'] + '/.config/perhoa/config.yaml'

  def self.run
    $config = File.size?(CONFIG_FILE) ? symbolise(YAML.load_file(CONFIG_FILE)) : Hash.new

    if already_running? 
      puts 'Sending messages to running Perhoa process...'
      send_message
      exit
    end

    read_config
    listener = SocketListener.new(ARGV)
    listener.listen
  end
end

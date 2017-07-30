require 'socket'
require_relative 'helper'

class SocketListener 
  def initialize arguments=[]
    read_arguments arguments
  end
  def listen 
    at_exit { FileUtils.rm SOCKET_FILE }
    server = UNIXServer.new SOCKET_FILE

    loop do
      client = server.accept
      arguments = YAML.load(client.read)
      read_arguments arguments
    end
  end

  def read_arguments arguments 
    arguments.each do |argument| 
      printf("Received message: %s\n", argument)
      daemon if argument == 'daemon'
      quit if argument == 'quit'
    end
  end
end

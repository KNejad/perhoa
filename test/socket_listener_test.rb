require 'minitest/autorun'
require_relative '../lib/socket_listener.rb'


describe SocketListener do
  def test_socket_starts
    assert_equal false, File.socket?(SOCKET_FILE)
    start_socket
    assert File.socket?(SOCKET_FILE)
    kill_daemon
  end

  def test_quits_on_quit_socket_message
    start_socket
    send_messages_to_socket "quit"
    wait_until_exit
    assert_equal false, File.socket?(SOCKET_FILE)
  end
end


def send_messages_to_socket messages
  messages = messages.join(' ') if messages.is_a?(Array)
  fork do
    Kernel.exec File.join(File.dirname(__FILE__), '../bin/perhoa') + ' ' +  messages + '> /dev/null'
  end
end

def start_socket
  capture_stdout do
    fork do
      listener = SocketListener.new(["daemon"])
      listener.listen
    end
  end
  wait_until_running
end

def capture_stdout &block
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

def kill_daemon
    send_messages_to_socket "quit"
    wait_until_exit
end

def wait_until_exit
    while already_running?
    end
end

def wait_until_running
  while !already_running?
  end
end

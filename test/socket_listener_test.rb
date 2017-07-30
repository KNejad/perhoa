require 'minitest/autorun'
require_relative '../lib/socket_listener.rb'


describe SocketListener do
  def test_socket_starts
    assert_equal false, File.socket?(SOCKET_FILE)
    start_socket
    sleep 1
    assert File.socket?(SOCKET_FILE)
    send_messages_to_socket "quit"
    sleep 1
  end

  def test_quits_on_quit_socket_message
    start_socket
    send_messages_to_socket "quit"
    sleep 1
    assert_equal false, File.socket?(SOCKET_FILE)
  end
end


def send_messages_to_socket messages
  capture_stdout do
    messages = messages.join(' ') if messages.is_a?(Array)
    fork do
      Kernel.exec './perhoa ' +  messages + '> /dev/null'
    end
  end
end

def start_socket
  capture_stdout do
    fork do
      listener = SocketListener.new(["daemon"])
      listener.listen
    end
  end
  sleep 1
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

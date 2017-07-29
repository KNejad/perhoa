SOCKET_FILE = "/tmp/perhoa.sock"

def asset file
  File.dirname(__FILE__) + '/assets/' + file
end


def alarm
  Thread.new do
    alarm_time = Time.parse($config[:alarm][:time])
    alarm_time += (24*60*60) if alarm_time - Time.now < 0 

    sleep_time = alarm_time - Time.now
    puts "Alarm set for " + alarm_time.to_s
    sleep(sleep_time)
    pid = fork{ exec 'mpg123','-q', asset('alarm.mp3') }
    sleep 5
    Process.kill('QUIT', pid)
  end
end

def symbolise hash
  hash.keys.each do |key|
    hash[key.to_sym] = hash[key]
    hash.delete(key)
    if hash[key.to_sym].is_a?(Hash)
      symbolise hash[key.to_sym]
    end
  end
  return hash
end

def run_socket 

  at_exit { FileUtils.rm SOCKET_FILE }

  server = UNIXServer.new SOCKET_FILE

  loop do
    client = server.accept
    arguments = YAML.load(client.read)
    read_arguments arguments
  end
end

def already_running? 
  File.socket?(SOCKET_FILE)
end

def send_message
  client = UNIXSocket.open SOCKET_FILE
  client.print ARGV.to_yaml
  client.close
end

def read_arguments arguments 
  arguments.each do |argument| 
    puts 'Hello' if argument == '--hello'
    Process.daemon(true, false) if argument == '--daemon'
    quit if argument == '--quit'
  end
end

def read_config
  alarm if $config[:alarm][:enabled]
end

def quit 
  puts 'Terminated via socket'
  exit 
end

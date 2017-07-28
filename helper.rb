def asset file
  File.dirname(__FILE__) + '/assets/' + file
end


def alarm config
  current = Thread.new do
    alarm_time = Time.parse(config[:time])
    if alarm_time - Time.now > 0 
      sleep_time = alarm_time - Time.now
    else
      sleep_time = alarm_time + (24*60*60) - Time.now
    end
    puts "Alarm set for " + alarm_time.to_s
    sleep(sleep_time)
    pid = fork{ exec 'mpg123','-q', asset('alarm.mp3') }
    sleep 5
    Process.kill('QUIT', pid)
  end
  current.join
  alarm config 
end

def symbolizse hash
  hash.keys.each do |key|
    hash[key.to_sym] = hash[key]
    hash.delete(key)
    if hash[key.to_sym].is_a?(Hash)
      symbolizse hash[key.to_sym]
    end
  end
  return hash
end

def run_socket 
  Thread.new do 
    socket_path = "/tmp/perhoa.sock"

    at_exit { FileUtils.rm socket_path }

    server = UNIXServer.new socket_path

    loop do
      client = server.accept
      message = client.read
      case 
      when message.include?('--quit')
        puts 'Terminated via socket'
        exit
      end
    end
  end
end

def already_running? 
  File.socket?('/tmp/perhoa.sock')
end

def send_message
  client = UNIXSocket.open "/tmp/perhoa.sock"
  client.print ARGV
  client.close
  exit
end

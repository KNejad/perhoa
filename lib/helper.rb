SOCKET_FILE = "/tmp/perhoa.sock"

def asset file
  File.join(File.dirname(__FILE__), '../assets/' + file)
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

def already_running? 
  File.socket?(SOCKET_FILE)
end

def send_message
  client = UNIXSocket.open SOCKET_FILE
  client.print ARGV.to_yaml
  client.close
end

def read_config
  Alarm.new($config[:alarm]) if $config[:alarm]
end

def quit 
  puts 'Terminated via socket'
  exit 
end

def daemon
  puts "Running as daemon"
  Process.daemon(true, false) 
end

pid = fork{ exec 'mpg123','-q', 'assets/alarm.mp3' }
sleep 5
Process.kill('QUIT', pid)
puts "Done"

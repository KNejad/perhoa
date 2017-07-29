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

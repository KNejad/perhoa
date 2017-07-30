require 'time'
require_relative 'helper'

class Alarm
  def initialize config
    config.each do |name, alarm|
      times = Array(alarm[:time])
      days = Array(alarm[:day])
      times.each do |time|
        days.each do |day|
          start day, time, name if alarm[:enabled]
        end
      end
    end
  end

  def start day, time, name
    d  = Date.parse(day)
    delta = d >= Date.today ? 0 : 7
    d = d + delta

    t = Time.parse(time)

    alarm_time =  DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)

    alarm_time += (alarm_time - DateTime.now) > 0 ? 0 : 7
    sleep_time = ((alarm_time - DateTime.now) * 24 * 60 * 60).to_i

    printf("Alarm '%s' set for %s\n", name, alarm_time.strftime('%a %Y-%m-%d at %H:%M:%S'))
    Kernel.sleep(sleep_time)
    pid = fork{ Kernel.exec 'mpg123','-q', asset('alarm.mp3') }
    Kernel.sleep 5
    Process.kill('QUIT', pid)
  end
end

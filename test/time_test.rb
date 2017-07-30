require 'minitest/autorun'
require_relative '../lib/alarm.rb'


describe Alarm do
  def test_alarm_set_for_1_minute_from_now
    now = DateTime.now  
    alarm_time = DateTime.new(now.year, 
                              now.month,
                              now.day,
                              now.hour,
                              now.minute + 1,
                              now.second,
                              now.zone)
    config = { 
      "name": {
        enabled: true,
        time: alarm_time.strftime("%H:%M:%S"),
        day: alarm_time.strftime('%a')
      }
    }

    alarm_output = "Alarm 'name' set for "  +  alarm_time.strftime('%a %Y-%m-%d at %H:%M:%S') + "\n"
    date_stubs do
      assert_output(alarm_output) { Alarm.new(config) }
    end
  end

  def test_multiple_alarms
    now = DateTime.now  
    alarm_1 = DateTime.new(now.year, 
                              now.month,
                              now.day,
                              now.hour,
                              now.minute + 1,
                              now.second,
                              now.zone)
    alarm_2 = alarm_1 + 1
    config = { 
      "alarm 1": {
        enabled: true,
        time: alarm_1.strftime("%H:%M:%S"),
        day: alarm_1.strftime('%a')
      },
      "alarm 2": {
        enabled: true,
        time: alarm_2.strftime("%H:%M:%S"),
        day: alarm_2.strftime('%a')
      }
    }

    alarm_output = 
      "Alarm 'alarm 1' set for "  +  alarm_1.strftime('%a %Y-%m-%d at %H:%M:%S') + "\n" +
      "Alarm 'alarm 2' set for "  +  alarm_2.strftime('%a %Y-%m-%d at %H:%M:%S') + "\n"
    date_stubs do
      assert_output(alarm_output) { Alarm.new(config) }
    end
  end


  def test_disabled_alarm
    now = DateTime.now  
    alarm_1 = DateTime.new(now.year, 
                              now.month,
                              now.day,
                              now.hour,
                              now.minute + 1,
                              now.second,
                              now.zone)
    config = { 
      "alarm 1": {
        enabled: false,
        time: alarm_1.strftime("%H:%M:%S"),
        day: alarm_1.strftime('%a')
      },
    }

    alarm_output = ""
    date_stubs do
      assert_output(alarm_output) { Alarm.new(config) }
    end
  end
end

def date_stubs 
  Thread.stub(:new, nil) do
    Kernel.stub(:loop, nil) do
      Kernel.stub(:sleep, nil) do
        Kernel.stub(:exec, nil) do 
          yield
        end
      end
    end
  end
end

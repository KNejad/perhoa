require 'minitest/autorun'
require_relative '../lib/alarm.rb'


describe Alarm do
  def test_alarm_set_for_mon_at_2
    config = { 
      "name": {
        enabled: true,
        time: "23:59:59",
        day: "mon"
      }
    }
    date  = Date.parse("Monday")
    delta = date >= Date.today ? 0 : 7
    date + delta
    date_string = date.strftime('%Y-%m-%d')
    Thread.stub(:initialize, nil) do
      Kernel.stub(:loop, nil) do
        Kernel.stub(:sleep, sleep(1)) do
          Kernel.stub(:exec, nil) do 
            alarm_output = "Alarm 'name' set for Mon "+ date_string + " at 23:59:59\n"
            assert_output(alarm_output) { Alarm.new(config) }
          end
        end
      end
    end
  end
end

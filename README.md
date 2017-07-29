# Perhoa
PERsonal HOme Assistant written in Ruby

## Dependencies: 
  * mpg123

## Usage
All configuration is in the `~/.config/perhoa/config.yaml` file

For sane defaults copy the `config.sample.yaml` to to `~/.config/perhoa/config.yaml`

### Alarm

To setup an alarm add the following to the config file:
```
alarm: 
  enabled: true
  time: "14:47"
  days: ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
```

`enabled`: Toggles the alarm status. `true` or `false`

`time`: The time the alarm will run. Either a string or a list of strings for the alarm times.

`days`: The days the alarm should run. Either a string or a list of strings for the alarm days. Where the day is the first 3 letters in the week day name

### Command line arguments:

You can start `Perhoa` and pass command line arguments or you can run Perhoa with arguments whilst another instance of Perhoa is already running. In the latter case the arguments will be passed to the already running perhoa instance.

`--daemon`: Runs Perhoa in the background

`--quit`: Quits Perhoa

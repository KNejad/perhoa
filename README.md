# Perhoa
PERsonal HOme Assistant written in Ruby

## Dependencies
  * mpg123

## Usage
All configuration is in the `~/.config/perhoa/config.yaml` file

To edit the default configuration, copy `config.sample.yaml` to `~/.config/perhoa/config.yaml`

### Alarm

To setup an alarm add the following to the config file:

```
alarm: 
  Alarm Name:
    enabled: true
    time: "14:47"
    day: ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
```

`Alarm Name`: The name of the alarm

`enabled`: Toggles the alarm status. `true` or `false`

`time`: The time the alarm will run. Either a string or a list of strings for the alarm times.

`day`: The day the alarm should run. Either a string or a list of strings for the alarm days.

### Command line arguments

You can start Perhoa and pass command line arguments directly, or you can run Perhoa with arguments whilst another instance of Perhoa is already running. In the latter case the arguments will be passed to the already running perhoa instance.

`daemon`: Runs Perhoa in the background

`quit`: Quits Perhoa

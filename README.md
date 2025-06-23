# Bin
My personal collection of scripts

- voice require the piper backend together with some voices


All the scripts (move in progress) put logs by default on "$HOME/logs/script_name.log"

## screenshot

- systemd unit: No
- voice : Yes
- notify: Yes
- logs: "$HOME/logs/screenshot.log"
- save to: "$HOME/multimedia/imagenes/screenshots"
- arguments: No
- other dependencies: grim

Takes a screenshot using grim. The screenshot has a name like:

```
screenshot_2025_mJun_d08_h14_m12_s32.png
```

This script sends notifications and voice in both success and failure

## log_api

- systemd unit: No
- voice : No
- notify: No
- logs: "$HOME/logs/log_api.log"
- save to: "$HOME/logs/$service"
- arguments: Yes
    + $service=${1:-default}: name of the script that run the log.
    + $level=${2:-info}: one of info|debug|warn|error. A wrong field sets it to error and logs the error.
    + $msg=${3:-}: the log message.
- other dependencies: No.

To use in other scripts to produce logs.

## log_cleaner

- systemd unit: Yes
- voice : No
- notify: No
- logs: No
- arguments: No
- other dependencies: No.

Truncate all log files on "$HOME/logs/" to 400 lines.
Is activated by a systemd unit every 7 days.

## run_with_env (Deprecated)
It used to be a way to enable environment variables before other parts
of the configuration where setted in the right way.

## usb_connection

- systemd unit: Yes
- voice : Yes
- notify: Yes
- logs: Yes
- arguments: No
- other dependencies: No.

Trigger a sound and a notification on usb plug/unplug.
It doens't check the kind of usb or other stuff.
It has a $MAX_DELTA_TIME, this is a delay time between udev
notification (udev triggers events more than once every time).

## voice

- systemd unit: No
- voice : No
- notify: No
- logs: No
- arguments:
    + optional $msg=$1
- other dependencies:
    + piper-tts
    + piper-voices (currently en_US-amy-medium, they must be on "$HOME/.local/share/piper_tts")

If invoked without arguments, read from stdin and use tts and paplay to
reproduce as sound.

If invoked with argument use tts and paplay to
reproduce as sound.

## audio_pair(Deprecated)
used to auto attempt reconnection to my old bluetooth speaker.
This includes forgetting at all the dispositive and try again
indefinitely.

## dumb_formatter
To be used inside vim/neovim, is for files without formatter.

## ask

- systemd unit: No
- voice : No
- notify: No
- logs: No
- arguments:
    + optional $input=$1
- other dependencies:
    + llava llamafile

If invoked without arguments, opens a temporal file in the neovim (TODO: use editor var) and
pass it's content to llam llm.

If invoked with argument pass it to llava llm.


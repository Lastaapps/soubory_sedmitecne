# Cheat cheat and idk, wtf, kill me now, please

## Volume control
```pacmixer - one to rule them all```
```alsamixer - global control```

## Power mode control
```powerprofilesctl get | list | set mode```

## Pacmanupdate
```pacman -Syu```

## File managers
`nnn`
`vifm`
`ranger`

## Random tools and commands
```darkman - dark theme switching```
```echo 150 | sudo tee /sys/class/backlight/intel_backlight/brightness```
### Enable Alacritty on my pi4
```infocmp | ssh "$user@$host" 'tic -x /dev/stdin'```

## Random
cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-69} | head -n 1
openssl rand -base64 32

## TODO
Alacritty config
tmux


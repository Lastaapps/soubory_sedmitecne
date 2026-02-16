# NixOS diary

My notes on what I did not manage to do in the NixOS config files.

## Wi-Fi

To connect to the Silicon Hill and Eduroam network, run:

```bash
nmcli con add type wifi ifname <INTERFACE> con-name <SSID> ssid <SSID> \
-- wifi-sec.key-mgmt wpa-eap \
802-1x.eap peap \
802-1x.phase2-auth mschapv2 \
802-1x.identity <USERNAME> \
802-1x.ca-cert <CERT-(BUNDLE)>

nmcli con up <SSID> --ask
```
You may need to change the interface name.
Then run `nm-connection-editor`, add radius servers (`radius.cvut.cz`, `sh.cvut.cz`) and system certificate bundle `/etc/ssl/certs/ca-bundle.crt`.

## Inspiration
- https://gitlab.com/vesecky.tomas/thompson-nix
- https://github.com/wiltaylor/dotfiles/


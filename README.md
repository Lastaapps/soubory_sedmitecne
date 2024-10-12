# NixOS diary

My notes on what I did not manage to do in the NixOS config files.

## Wi-Fi

To connect to the Silicon Hill and Eduroam network, run:

```bash
nmcli con add type wifi ifname <INTERFACE> con-name "SiliconHill" ssid "SiliconHill" -- wifi-sec.key-mgmt wpa-eap 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity <USERNAME>
nmcli con up SiliconHill --ask

nmcli con add type wifi ifname <INTERFACE> con-name eduroam ssid eduroam 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity <USERNAME>@cvut.cz wifi-sec.key-mgmt wpa-eap
nmcli con up SiliconHill --ask
```
You may need to change the interface name.
Then run `nm-connection-editor`, add radius servers (`radius.cvut.cz`, `sh.cvut.cz`) and system certificate bundle `/etc/ssl/certs/ca-bundle.crt`.



#!/usr/bin/env sh

vpn_config_file=/home/fabio/Nextcloud/Documenti/Lavoro/ofcourse.me/VPN/fabio.sussarellu/client.ovpn
vpn_username=fabio.sussarellu
vpn_password_file=/home/fabio/Nextcloud/Documenti/Lavoro/ofcourse.me/VPN/fabio.sussarellu/pass
vpn_password="$(cat $vpn_password_file)"

vpnup() {
    # Connect to VPN
    printf "Insert OTP code: "
    read -r otp
    printf "%s\n%s\n%s\n" "$vpn_username" "$vpn_password" "$otp" | openvpn3 session-start --config "$vpn_config_file"
}

vpnls() {
    # List of VPN sessions
    openvpn3 sessions-list
}

vpndown() {
    # Disconnect from VPN
    openvpn3 session-manage --disconnect --config "$vpn_config_file"
}

vpnhelp() {
    # Help
    printf "Usage: vpn [up|down|ls]\n\n\
\tup: connect to VPN\n\
\tdown: disconnect from VPN\n\
\tls: list VPN sessions\n"
}

[ "$1" = "up" ] && vpnup && exit 0
[ "$1" = "ls" ] && vpnls && exit 0
[ "$1" = "down" ] && vpndown && exit 0

vpnhelp && exit 0
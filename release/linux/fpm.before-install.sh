getent group plugdev >/dev/null || groupadd -r plugdev
getent group chargerwalletd >/dev/null || groupadd -r chargerwalletd
getent passwd chargerwalletd >/dev/null || useradd -r -g chargerwalletd -d /var -s /bin/false -c "ChargerWallet Bridge" chargerwalletd
usermod -a -G plugdev chargerwalletd
touch /var/log/chargerwalletd.log
chown chargerwalletd:chargerwalletd /var/log/chargerwalletd.log
chmod 660 /var/log/chargerwalletd.log

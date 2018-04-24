#!/bin/bash -e

CA_NAME=ca
SERVER_NAME=server
EASY_RSA=/usr/share/easy-rsa

mkdir -p /etc/openvpn/keys
touch /etc/openvpn/keys/index.txt
echo 01 > /etc/openvpn/keys/serial
cp -f /opt/scripts/vars.template /etc/openvpn/keys/vars
cp -f /opt/scripts/crl.pem.template /etc/openvpn/keys/crl.pem

$EASY_RSA/clean-all
source /etc/openvpn/keys/vars
export KEY_NAME=$CA_NAME
echo "Generating CA cert"
#$EASY_RSA/build-ca
export EASY_RSA="${EASY_RSA:-.}"

$EASY_RSA/pkitool --initca $*

export KEY_NAME=$SERVER_NAME

echo "Generating server cert"
#$EASY_RSA/build-key-server $SERVER_NAME
$EASY_RSA/pkitool --server $SERVER_NAME

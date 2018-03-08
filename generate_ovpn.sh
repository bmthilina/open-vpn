#!/bin/bash

# First argument: Client identifier
if [ "$1" == "" ]
then
    echo "Usage: $0 <client-name>"
    exit 1
fi

KEY_DIR=~/ovpn/keys
OUTPUT_DIR=~/ovpn/clients
BASE_CONFIG=~/ovpn/config/base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn

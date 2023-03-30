#!/bin/bash

function check() {
    username=$1
    traffic=$2
    if [[ -z $username ]]; then
        echo "username is required"
        exit 1
    fi
    if [[ -z $traffic ]]; then
        echo "traffic is required"
        exit 1
    fi
    if [[ ! $traffic =~ ^[0-9]+$ ]]; then
        echo "traffic must be a number"
        exit 1
    fi
    current=$(iptables -nvx -L OUTPUT | grep "ssh_$username" | tr -s ' ' | cut -d ' ' -f 3)
    if [[ $current -gt $traffic ]]; then
        # TODO: remove user
    fi
}
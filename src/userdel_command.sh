username=${args[username]}

if [[ -z $username ]]; then
    echo "username is required"
    exit 1
fi

userdel -r $username

rule=$(iptables -S | grep OUTPUT | grep ssh_$username)
if [[ -n $rule ]]; then
    iptables -D OUTPUT $rule
    iptables -X ssh_$username
    iptables-save > /etc/iptables/rules.v4
fi

# TODO: remove lines from cron.sh and sshd_config

echo "User deleted successfully"

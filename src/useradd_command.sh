CONFIG_DIR="$HOME/.mush"
USERS_FILE="$CONFIG_DIR/users.json"
PORT_FILE="$CONFIG_DIR/port"
LOG_FILE="$CONFIG_DIR/mush.log"
CRON_FILE="$CONFIG_DIR/cron.sh"

username=${args[--username]}
if [[ -z $username ]]; then
    username=$(openssl rand -hex 8)
fi
password=${args[--password]}
if [[ -z $password ]]; then
    password=$(openssl rand -hex 16)
fi
expire=${args[--expire]}
traffic=${args[--traffic]}

encrypted=$(openssl passwd -1 $password)

result=$(useradd -e $expire -M -s /bin/true -p $encrypted $username)
if [[ $result == "useradd: user '$username' already exists" ]]; then
    echo "user already exists"
    exit 1
fi

port=$(cat $PORT_FILE)
echo $((port + 1)) > $PORT_FILE
echo "Match Port $port" >> /etc/ssh/sshd_config
echo "\tPermitUser $username" >> /etc/ssh/sshd_config

iptables -N ssh_$username
iptables -A OUTPUT -p tcp --sport $port -j ssh_$username
iptables-save > /etc/iptables/rules.v4

echo "check($username, $traffic)" >> $CRON_FILE

echo "User created successfully"
echo "Username: $username"
echo "Password: $password"
echo "Port: $port"

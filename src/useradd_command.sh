username=${args[--username]}
if [[ -z $username ]]; then
    username=$(openssl rand -hex 16)
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

echo "User created successfully"
echo "Username: $username"
echo "Password: $password"
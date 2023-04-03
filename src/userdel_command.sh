username=${args[username]}

if [[ -z $username ]]; then
    echo "username is required"
    exit 1
fi

result=$(userdel -r $username)
if [[ $result == "userdel: user '$username' does not exist" ]]; then
    echo "user does not exist"
    exit 1
fi

echo "User deleted successfully"

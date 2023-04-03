KEYWORD="ssh_"

result=$(iptables -L OUTPUT -n -v)

echo "$result" | head -n 2
echo "$result" | grep $KEYWORD

CONFIG_DIR="$HOME/.mush"
USERS_FILE="$CONFIG_DIR/users.json"
LOG_FILE="$CONFIG_DIR/mush.log"
CRON_FILE="$CONFIG_DIR/cron.sh"

force=${args[--force]}

if [[ -d $CONFIG_DIR && -z $force ]]; then
    echo "Mush is already initialized"
    exit 1
fi

if [[ -d $CONFIG_DIR && -n $force ]]; then
    rm -rf $CONFIG_DIR
fi

mkdir -p $CONFIG_DIR

echo "[]" > $USERS_FILE
touch $LOG_FILE
touch $CRON_FILE
chmod +x $CRON_FILE
# TODO: add cron job

echo "Mush initialized successfully"
DIRECTION=$1

DIR=$(dirname $0)

for window in living4 living5 living6 living7; do
  echo "$window $DIRECTION"
  bash $DIR/../$window/$DIRECTION.sh
  sleep 5
done

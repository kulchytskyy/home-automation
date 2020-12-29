DIRECTION=$1

DIR=$(dirname $0)

for window in kitchen living1 living2 living3 living4 living5 living6 living7 bedroom; do
  echo "$window $DIRECTION"
  bash $DIR/../$window/$DIRECTION.sh
  sleep 5
done

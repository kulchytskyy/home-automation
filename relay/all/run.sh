DIRECTION=$1

DIR=$(dirname $0)

for window in kitchen living1 living2 ; do
  echo "$window $DIRECTION"
  bash $DIR/../$window/$DIRECTION.sh
  sleep 5
done

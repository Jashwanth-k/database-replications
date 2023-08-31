mongosh --host "$HOST" --port "$PORT1" --authenticationDatabase admin --username "$USERNAME" --password "$PASSWORD" --eval "
rs.initiate({
  _id: '$REPLSET1',
  members: [
    { _id: 0, host : '$HOST:$PORT1', priority : 2 },
    { _id: 1, host : '$HOST:$PORT2' },
    { _id: 2, host : '$HOST:$PORT3' },
  ]
})
"

mongosh --host "$HOST" --port "$PORT4" --authenticationDatabase admin --username "$USERNAME" --password "$PASSWORD" --eval "
rs.initiate({
  _id: '$REPLSET2',
  members: [
    { _id: 0, host : '$HOST:$PORT4', priority : 2 },
    { _id: 1, host : '$HOST:$PORT5' },
    { _id: 2, host : '$HOST:$PORT6' },
  ]
})
"

mongosh --host "$HOST" --port "$PORT7" --authenticationDatabase admin --username "$USERNAME" --password "$PASSWORD" --eval "
rs.initiate({
  _id: '$CFGSET1',
  configsvr : true,
  members: [
    { _id: 0, host : '$HOST:$PORT7', priority : 2 },
    { _id: 1, host : '$HOST:$PORT8' },
    { _id: 2, host : '$HOST:$PORT9' },
  ]
})
"

mongosh --host "$HOST" --port "$PORT10" --username "$USERNAME" --password "$PASSWORD" --eval "
sh.addShard('$REPLSET1/$HOST:$PORT1')
sh.addShard('$REPLSET2/$HOST:$PORT4')
"


# How many new outputs were created by block 123,456?

total_vouts=0
blockhash=$(bitcoin-cli getblockhash 123456)
txids=$(bitcoin-cli getblock "$blockhash" true | jq -r '.tx[]')

for txid in $txids; do
  vouts=$(bitcoin-cli getrawtransaction "$txid" true | jq '.vout | length')
  total_vouts=$(($total_vouts + $vouts))
done

echo $total_vouts

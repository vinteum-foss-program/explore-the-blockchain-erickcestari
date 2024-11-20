# Which tx in block 257,343 spends the coinbase output of block 256,128?

blockhash_coinbase=$(bitcoin-cli getblockhash 256128)
coinbase=$(bitcoin-cli getblock "$blockhash_coinbase" true | jq -r '.tx[0]')

blockhash=$(bitcoin-cli getblockhash 257343)
txids=$(bitcoin-cli getblock "$blockhash" true | jq -r '.tx[]')

for txid in $txids; do
  txinputs=$(bitcoin-cli getrawtransaction "$txid" true | jq -r '.vin[].txid')
  for txinput in $txinputs; do
    if [[ "$txinput" == "$coinbase" ]]; then
      echo $txid
      break 2
    fi
  done
done
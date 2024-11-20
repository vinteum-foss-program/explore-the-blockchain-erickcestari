# Only one single output remains unspent from block 123,321. What address was it sent to?

blockhash=$(bitcoin-cli getblockhash 123321)
txids=$(bitcoin-cli getblock "$blockhash" true | jq -r '.tx[]')

for txid in $txids; do
  utxo=$(bitcoin-cli gettxout $txid 0)
  if [[ -n "$utxo" ]]; then
    echo $(echo $utxo | jq -r '.scriptPubKey.address')
    break
  fi
done
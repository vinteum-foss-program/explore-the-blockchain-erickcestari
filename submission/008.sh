# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

txid=e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163
rawtx=$(bitcoin-cli getrawtransaction $txid true)

pubkey_script=$(echo $rawtx | jq -r '.vin[0].txinwitness[2]')

pubkey=$(echo $pubkey_script | sed -E 's/^.*6321([a-f0-9]{66}).*$/\1/')
echo $pubkey

# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

TX_HASH="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

RAW_TX=$(bitcoin-cli getrawtransaction $TX_HASH 1)

PUBLIC_KEYS=$(echo "$RAW_TX" | jq -r '.vin[].txinwitness[1]' | jq -R . | jq -s .)

M=1

MULTISIG_ADDRESS=$(bitcoin-cli createmultisig $M "$PUBLIC_KEYS")

echo $MULTISIG_ADDRESS | jq -r .address

#  BDG Daily Wallet

A bitcoin wallet app template for iOS. 

Intended as a good starting point for new bitcoin wallet projects.
This is WORK IN PROGRESS.

### Dependencies
- Bitcoin Development Kit - to interact with the bitcoin blockchain via Electrum or Esplora APIs
- Lightning Development Kit - not yet implemented
- KeychainAccess - to store encrypted data in keychain

### Implemented features
- Create new HD Segwit wallets using BIP84 derivation paths (12 word recovery-phrase, no pass-phrase)
- Import wallet from recovery phrase (12 or 24 word recovery-phrase, no pass-phrase)

### Wallet types
Currently only supports single key HD segwit wallets with BIP84 derivation paths
Descriptors created by the app will look like: `wpkh([extended private key]/84'/1'/0'/0/*)` 

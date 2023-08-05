## Foundry Installation Guide: 

This setup assumes you have the general basic requirements for development already setup on your machine.  
   Git Bash - https://git-scm.com/downloads
   Node
   NPM
   VSCode
   Solidity Extensions for VsCode



In a git bash terminal
  - `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
  - `cargo install --git https://github.com/foundry-rs/foundry --profile local --force foundry-cli anvil chisel`
	
This will allow you to import using @openzeppelin to reference that folder and so on, if you're using vs code you can install the remappings at the settings level:

open up the settings and type solidity the modify the settings.json
	{
		"solidity.packageDefaultDependenciesDirectory": "\"node_modules\", \"lib\"",
		"solidity.remappings": [
			"forge-std=lib/forge-std/src",
			"ds-test=lib/forge-std/lib/ds-test/src",
			"@openzeppelin=lib/openzeppelin-contracts",
			"@uniswapv4core=lib/v4-core/contracts"
		],
		"solidity.remappingsUnix": [
			"forge-std=lib/forge-std/src",
			"ds-test=lib/forge-std/lib/ds-test/src",
			"@openzeppelin=lib/openzeppelin-contracts",
			"@uniswapv4core=lib/v4-core/contracts"
		]
	}

build the project:

  `forge build`
  
Run the tests:
 
  `forge test`


References:

https://www.linkedin.com/pulse/how-install-foundry-windows-pablo-rego
https://jamesbachini.com/foundry-tutorial/



## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```



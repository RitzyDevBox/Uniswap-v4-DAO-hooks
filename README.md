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

# Build the project:

  `forge build`
  
# Run the tests:
 
  `forge test`

# Foundry Cheat Sheet

Essential Cheat Codes – Full list here: https://github.com/foundry-rs/forge-std/blob/master/src/Vm.sol

vm.warp(uint256) external; Set block.timestamp
vm.roll(uint256) external; Set block.height
vm.prank(address) external; Sets the next calls msg.sender to be the input address
vm.startPrank(address) external; Sets all subsequent calls msg.sender to be the input address
vm.stopPrank() external; Resets subsequent calls msg.sender to be `address(this)`
vm.deal(address, uint256) external; Sets an addresses balance, (who, newBalance)
vm.expectRevert(bytes calldata) external; Expects an error on next call
vm.record() external; Record all storage reads and writes
vm.expectEmit(true, false, false, false); emit Transfer(address(this)); transfer(); Check event topic 1 is equal on both events
vm.load(address,bytes32) external returns (bytes32); Loads a storage slot from an address
vm.store(address,bytes32,bytes32) external; Stores a value to an addresses storage slot, (who, slot, value)


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



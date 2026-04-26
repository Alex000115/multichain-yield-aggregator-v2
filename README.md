# Multichain Yield Aggregator V2

This repository features a professional, flat-structure implementation of a cross-chain yield aggregator. It is designed to maximize capital efficiency by identifying and moving liquidity to the highest APR pools across different L1 and L2 networks.

### Core Strategy
* **Chain Scanning:** Off-chain workers monitor APY/TVL data from protocols like Aave, Curve, and Uniswap across Ethereum, Polygon, and Arbitrum.
* **Capital Routing:** Uses LayerZero or Axelar messaging protocols to trigger cross-chain rebalancing.
* **Risk Management:** Implements "Safety Score" filters to avoid high-yield but low-security protocols.

### Key Components
* **AggregatorCore.sol:** Manages user deposits and issues yield-bearing receipts.
* **StrategyManager.sol:** Interfaces with various cross-chain bridges to move assets.
* **ApyOracle.sol:** A decentralized data feed for current market yields.

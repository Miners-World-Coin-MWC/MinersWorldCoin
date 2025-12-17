<h1 align="center">
<!-- <img src="https://i.imgur.com/uktT3CY.png" alt="MinersWorldCoin" width="300"/> -->
<br/><br/>
MinersWorldCoin Core [MWC]  
</h1>

Select language: EN | [CN](./translations/README_zh_CN.md) | [PT](./translations/README_pt_BR.md) | [FA](./translations/README_fa_IR.md) | [VI](./translations/README_vi_VN.md) | [JA](./translations/README_ja_JP.md)

![CPU Only](https://img.shields.io/badge/Mining-CPU%20Only-orange)
![No ASICs](https://img.shields.io/badge/ASIC-Resistant-green)
![No Premine](https://img.shields.io/badge/Launch-No%20Premine-brightgreen)
![No ICO](https://img.shields.io/badge/ICO-None-red)


## Welcome, Miner! ⛏️  
Welcome to **MinersWorldCoin**, a cryptocurrency forged with one goal in mind: **fair, accessible mining for everyone**.

MinersWorldCoin is not a get-rich-quick scheme, not an ICO cash grab, and not an ASIC playground. There is **no ICO, no premine, and no hidden advantages** — just honest mining, powered by CPUs.

Whether you’re running an old desktop, a home server, or a modern workstation, **your CPU is your pickaxe**. If you can compute, you can mine. That’s the foundation of MinersWorldCoin: decentralization through accessibility.

MinersWorldCoin Core is the reference implementation of the network, providing a **Layer-1 blockchain** secured by the **yespowerMWC** algorithm — designed to resist ASIC domination and keep mining fair, distributed, and community-driven.

For information about the default fees used on the MinersWorldCoin network, please refer to the [fee recommendation](doc/fee-recommendation.md).

**Website:** [MinersWorldCoin](https://www.minersworld.org/)

---

## The Mining World of MinersWorldCoin 🌐

MinersWorldCoin is built around a simple principle:  
**one CPU, one voice.**

No specialized hardware. No insider advantages. No centralized issuance. Coins are created the same way for everyone — by contributing real computational work to the network.

**Key Features:**
- **CPU-Only Mining** — Accessible to anyone with a processor  
- **No ASIC Mining** — Prevents industrial centralization  
- **No ICO** — No pre-sold supply  
- **No Premine** — Fair launch from block one  
- **Decentralized by Design** — Power stays with the miners

---

### Build Targets

| Platform | Architecture | Folder | Status |
|--------|--------------|--------|--------|
| Linux | x86_64 | `x86_64-linux` | ![Linux x86_64](https://img.shields.io/badge/Linux-x86__64-success?logo=linux) |
| Linux | i686 | `i686-linux` | ![Linux i686](https://img.shields.io/badge/Linux-i686-success?logo=linux) |
| Linux | ARM64 | `aarch64-linux` | ![Linux ARM64](https://img.shields.io/badge/Linux-ARM64-success?logo=linux) |
| Linux | ARMHF | `armhf-linux` | ![Linux ARMHF](https://img.shields.io/badge/Linux-ARMHF-success?logo=linux) |
| Windows | x86_64 | `x86_64-win` | ![Windows x64](https://img.shields.io/badge/Windows-x86__64-success?logo=windows) |
| Windows | i686 | `i686-win` | ![Windows x86](https://img.shields.io/badge/Windows-i686-success?logo=windows) |
| macOS | Intel | `x86_64-macos` | ![macOS Intel](https://img.shields.io/badge/macOS-Intel-success?logo=apple) |

---

## Built for Real Miners ⚙️

MinersWorldCoin takes inspiration from the early days of cryptocurrency — when mining was something **anyone** could do from home. Like Dogecoin in spirit, but with a strict focus on **CPU fairness**.

There are no GPUs racing ahead, no ASIC farms squeezing out small miners. If you contribute CPU power, you contribute to the security of the chain — and you earn your share honestly.

Mining here isn’t about who has the biggest rig.  
It’s about participation.

---

## Usage Guide 🧭

To start mining or running a node, follow the [installation guide](INSTALL.md) and the [getting started tutorial](doc/getting-started.md).

MinersWorldCoin Core includes a fully featured, self-documenting **JSON-RPC API**.  
Use:

`minersworldcoin-cli help`


For deeper technical reference, the [Bitcoin Core RPC documentation](https://developer.bitcoin.org/reference/rpc/) applies, as MinersWorldCoin follows the same foundational standards.

---

### Network Ports ⚡

These ports are used by the **MinersWorldCoin** network:

| Function | mainnet | testnet | regtest |
| :------- | ------: | ------: | ------: |
| P2P      |   4403  |  14403  |  24403  |
| RPC      |   5579  |  15579  |  18433  |

⚠️ **Security Notice:**  
Do **not** expose RPC ports to the public internet. RPC access controls wallets and node operations and should remain private.

---

## Ongoing Development 🛠️

**MinersWorldCoin Core** is fully open-source and community-driven. Development is transparent, collaborative, and guided by the needs of miners and node operators.

Get involved:
- [GitHub Projects](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/projects) — Track current and planned development
- [GitHub Discussions](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/discussions) — Propose ideas and improvements
- [MinersWorldCoin subreddit](https://www.reddit.com/r/MinersWorldCoin/) — Community discussions and updates

---

### Versioning and Branches 🧱

Versioning follows **major.minor.patch**.

Branch structure:
- **master** — Latest stable release
- **maintenance** — Previous releases under maintenance
- **development** — Active development and new features

Contribution flow:
- **New Features** → `development`
- **Bug Fixes** → `maintenance`

---

## Contributing 🤝

MinersWorldCoin is built by its community. If you mine it, run it, or believe in fair crypto — you’re already part of the project.

You can help by:
- Reporting bugs
- Suggesting improvements
- Submitting pull requests

Start here:  
👉 [Issue Tracker](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D+)

See the [contribution guide](CONTRIBUTING.md) for full details.

---

## Join the Community 🌍

Mining is better together. Connect with other miners, developers, and supporters to share knowledge, updates, and progress.

- [Discord](https://discord.gg/5HZGx5bbKK)
- [Telegram](https://t.me/+0IfF9E76ETZiNDQ8)

---

## Frequently Asked Questions ❓

Many common questions are answered in the [FAQ](doc/FAQ.md) or in the [Q&A section](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/discussions/categories/q-a).

---

## License ⚖️

MinersWorldCoin Core is released under the **MIT License**.  
See [COPYING](COPYING) or visit [opensource.org](https://opensource.org/licenses/MIT).

---

⛏️ **Ready to mine?**  
Plug in your CPU, support decentralization, and help secure the network — one hash at a time.

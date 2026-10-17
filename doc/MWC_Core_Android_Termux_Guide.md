# Miners World Coin (MWC) Core on Android with Termux

Run the **Miners World Coin (MWC) Core command-line software** on a compatible Android device using Termux.

- **Release:** `1.0.0.2`
- **Package:** Android ARM64 / Termux ZIP
- **Download:** https://github.com/Miners-World-Coin-MWC/MinersWorldCoin/releases/download/1.0.0.2/minersworldcoin-android-arm64-termux.zip
- **Project:** https://github.com/Miners-World-Coin-MWC/MinersWorldCoin
- **Termux project:** https://github.com/termux/termux-app

> **Important:** This guide is for the MWC Core command-line node, not the separate graphical Android mobile wallet. Running a node does not automatically mean you are mining MWC or earning rewards.

The commands below assume the ZIP contains a daemon named `minersworldcoind` and a CLI named `minersworldcoin-cli`. **Confirm the actual filenames in the ZIP before running commands that use them.** If the names differ, substitute the names supplied by the release.

## 1. Requirements

- An Android device with a 64-bit ARM processor.
- Termux installed from a trusted, current source.
- A reliable internet connection.
- Enough free storage for the software and blockchain data. The amount required depends on the current chain size and can grow over time.
- Time for the node to download and verify blockchain data.

Install Termux from the official project page:

https://github.com/termux/termux-app

Avoid outdated Termux builds. Do not install binaries or libraries from untrusted download sites.

## 2. Update Termux and install tools

Open Termux and run:

```bash
pkg update && pkg upgrade -y
pkg install wget unzip file -y
```

Allow the commands to finish. If Termux asks a question during an upgrade, read the prompt and follow the instructions shown.

## 3. Download the official MWC release

Create a working directory and download the release ZIP:

```bash
mkdir -p ~/mwc
cd ~/mwc

wget -O minersworldcoin-android-arm64-termux.zip \
"https://github.com/Miners-World-Coin-MWC/MinersWorldCoin/releases/download/1.0.0.2/minersworldcoin-android-arm64-termux.zip"
```

Check that the downloaded file exists and is not empty:

```bash
ls -lh minersworldcoin-android-arm64-termux.zip
```

Optionally, compare its checksum with a checksum published by the project, if one is provided. Do not treat a checksum generated only from your own download as proof that the file is authentic.

## 4. Inspect and extract the ZIP

First inspect the archive's contents:

```bash
unzip -l minersworldcoin-android-arm64-termux.zip
```

Extract it into a separate directory:

```bash
mkdir -p ~/mwc/extracted
unzip minersworldcoin-android-arm64-termux.zip -d ~/mwc/extracted
cd ~/mwc/extracted
```

List the files:

```bash
find . -maxdepth 3 -type f
```

Identify the architecture and file types:

```bash
uname -m
find . -maxdepth 3 -type f -exec file {} \;
```

For this ARM64 release, `uname -m` should normally report:

```text
aarch64
```

Look for the daemon and command-line client supplied by the ZIP. In the examples below, these are referred to as `minersworldcoind` and `minersworldcoin-cli`. Your release may use different names or a different directory layout.

## 5. Make the executables runnable

If the daemon and CLI are in the current directory and have the assumed names, run:

```bash
chmod +x ./minersworldcoind ./minersworldcoin-cli
```

If either file is in a subdirectory, use its actual path. If the filenames differ, replace them with the real filenames.

Check the daemon's supported options:

```bash
./minersworldcoind --help
```

If supported by the build, you can also check its version:

```bash
./minersworldcoind --version
```

Some builds do not implement these exact options. If a command is rejected, consult the release's included documentation or the project's README rather than assuming another flag is supported.

## 6. Start the node in the foreground first

Start the daemon from the directory containing the executable:

```bash
./minersworldcoind
```

Watch the terminal for startup messages, configuration errors, missing dependencies, and peer-connection messages.

Keep this session open while testing. Starting in the foreground is useful because error messages remain visible. Do not assume the node has started successfully unless the output confirms it.

If startup reports a missing library, do not download a random replacement. Record the exact error and investigate which compatible Termux package or release build is required.

If the program reports that a configuration file is missing, use the configuration format and paths documented by the MWC project. Do not invent RPC credentials, network ports, or configuration directives.

## 7. Open a second Termux session and check the node

If the daemon remains running in the first session, open a second Termux session. Change to the directory containing the CLI and run the commands supported by your build.

Assuming the CLI is named `minersworldcoin-cli` and is in `~/mwc/extracted`:

```bash
cd ~/mwc/extracted
./minersworldcoin-cli --help
```

If the CLI supports the standard Bitcoin-derived RPC commands, try:

```bash
./minersworldcoin-cli getblockchaininfo
./minersworldcoin-cli getnetworkinfo
./minersworldcoin-cli getpeerinfo
```

These commands can report blockchain synchronisation information, network details, and connected peers. They may fail if the daemon is not running, RPC is not configured, the CLI uses different command syntax, or the node is still starting.

A successful command response is a better indicator than simply seeing a process in the terminal. Initial blockchain synchronisation can take a significant amount of time.

## 8. Optional: run in the background

Only try background mode after the node has started successfully in the foreground and you have confirmed that the build supports the relevant option.

Check the daemon's help output:

```bash
./minersworldcoind --help
```

If the help explicitly confirms support for `-daemon`, you can try:

```bash
./minersworldcoind -daemon
```

Then check status using the CLI:

```bash
./minersworldcoin-cli getblockchaininfo
```

If `-daemon` is not supported, do not use it. Use a method documented for this specific build. Background execution on Android can also be interrupted by the operating system.

## 9. Stop the node cleanly

If the CLI supports the standard stop command, run:

```bash
./minersworldcoin-cli stop
```

Wait for the node to shut down. If the CLI cannot connect, check whether the daemon is still running and inspect its terminal output.

Avoid force-closing Termux while the node is writing data unless there is no alternative.

## 10. Storage, battery, and Android background limits

- Keep enough free storage available for blockchain data and future growth.
- Use a reliable Wi-Fi connection for initial synchronisation where possible.
- Keep the device cool and avoid sustained heavy CPU workloads.
- Consider Android battery optimisation settings if the node stops while Termux is in the background. Available settings vary by device.
- Do not assume Android will keep a background process running indefinitely.
- Keep the node's data directory in Termux's private storage unless the project documents a different supported setup.

A node downloading and validating blocks is not the same as a miner submitting proof-of-work shares or blocks.

## 11. Security guidance

- Download releases from the official MWC project or a trusted project-controlled source.
- Never share your wallet seed phrase, private keys, RPC password, or wallet backup.
- Do not expose the node's RPC interface to the public internet.
- Keep RPC access local to the device unless the project documents a secure alternative.
- Do not copy commands from strangers that ask you to run unknown scripts or send wallet data.
- Back up wallet material securely and separately. Do not assume blockchain data is a wallet backup.
- Verify release checksums or signatures when the project publishes them.

## 12. Troubleshooting

### `uname -m` does not show `aarch64`

The release may not match your device or environment. Stop and confirm your Android device architecture before continuing.

### `Permission denied`

Confirm that you are using the correct executable and have permission to run it. For an executable in the current directory:

```bash
chmod +x ./minersworldcoind
```

Replace the filename with the actual daemon filename if needed.

### `No such file or directory`

Check the filename and path:

```bash
find ~/mwc/extracted -maxdepth 3 -type f
```

This error can also occur if a binary requires an interpreter or runtime that is unavailable in the environment. Check the output of `file` and the exact error before changing anything.

### Missing shared library

Copy the complete error message and check the required library against Termux packages and the release documentation. Do not install libraries from untrusted websites.

### CLI cannot connect to the server

- Check that the daemon is running.
- Review the daemon's terminal output.
- Confirm the CLI's supported RPC commands and configuration.
- Confirm the configured local RPC settings match what the CLI expects.
- Do not expose the RPC port publicly as a troubleshooting shortcut.

### No peers or synchronisation appears stuck

Check the network connection, the node's output, the device's date/time, and the project's current network status. Synchronisation may take time. Do not assume a particular port or peer address unless it is documented for this release.

### Android stops the process

Check battery optimisation and background execution settings for Termux. Android device manufacturers may apply additional restrictions.

## 13. Recording a tutorial video

For a trustworthy tutorial, capture the real Termux screen rather than relying on AI-generated terminal text. AI video generators often produce incorrect commands and filenames.

Suggested 30-second structure:

1. **0–4 seconds:** MWC logo and title: “MWC Core on Android with Termux”.
2. **4–12 seconds:** Show the official release download and extraction.
3. **12–20 seconds:** Show the real daemon startup output.
4. **20–26 seconds:** Show a successful blockchain or network status query, if available.
5. **26–30 seconds:** Show the official GitHub release link and invite viewers to explore MWC.

Before publishing, hide private information, wallet addresses that you do not want public, seed phrases, private keys, RPC credentials, and any other sensitive terminal output.

### AI video prompt: cinematic intro

> Create a vertical 9:16 cinematic introduction for Miners World Coin (MWC). Use a dark background with gold and teal lighting, a mountain-mining logo, and a friendly green alien miner mascot wearing a white helmet with cyan lights and blue overalls marked MWC. Show a modern Android phone with a generic terminal interface. Premium community-driven cryptocurrency aesthetic, smooth camera movement, clean composition, crisp detail. Leave clear space for the editor to add the exact title “MWC Core on Android with Termux”. Do not generate readable command-line instructions, fake balances, price claims, or guaranteed earnings.

### AI video prompt: tutorial transitions

> Create a short vertical technology-video transition for a real Android Termux tutorial. Show close-up shots of a phone, a dark terminal interface, and gold-and-teal network graphics. Include the MWC green alien miner mascot as a guide. Leave the terminal screen blank or generic so real screen recordings can be inserted during editing. Do not invent commands, transaction results, block heights, or wallet balances. Smooth, professional, accessible visual style.

### AI video prompt: closing screen

> Create a polished vertical closing screen for Miners World Coin (MWC), using the established gold, teal, and dark colour palette, mountain-mining logo, and friendly green alien miner mascot in MWC workwear. Leave a clean central area for the editor to overlay “Explore MWC Core for Android” and the official GitHub release URL. Community-focused, modern, trustworthy, no price predictions, no promises of profit, and no fake mining statistics.

## 14. Official links

- **Download MWC Core Android ARM64 Termux ZIP (1.0.0.2):**  
  https://github.com/Miners-World-Coin-MWC/MinersWorldCoin/releases/download/1.0.0.2/minersworldcoin-android-arm64-termux.zip
- **MWC Core repository:**  
  https://github.com/Miners-World-Coin-MWC/MinersWorldCoin
- **Termux project:**  
  https://github.com/termux/termux-app

## Final note

This guide is based on the release URL and a typical Termux workflow. The exact executable names, command-line options, configuration paths, and RPC commands must be verified against the contents and documentation of release `1.0.0.2`. If a command fails, save the complete error output and check the project's official documentation before proceeding.

<h1 align="center">
<img src="https://github.com/Miners-World-Coin-MWC/MinersWorldCoin/blob/main/src/qt/res/icons/bitcoin.png" alt="MinersWorldCoin" width="300"/>
<br/><br/>
MinersWorldCoin Core [MWC]
</h1>

言語を選択: EN | [CN](./translations/README_zh_CN.md) | [PT](./translations/README_pt_BR.md) | [FA](./translations/README_fa_IR.md) | [VI](./translations/README_vi_VN.md) | [JA](./translations/README_ja_JP.md)

![CPUのみ](https://img.shields.io/badge/Mining-CPU%20Only-orange)
![ASIC不可](https://img.shields.io/badge/ASIC-Resistant-green)
![プレマイニング不可](https://img.shields.io/badge/Launch-No%20Premine-brightgreen)
![ICO不可](https://img.shields.io/badge/ICO-None-red)

## マイナーの皆様、ようこそ！⛏️
**MinersWorldCoin** へようこそ。この暗号通貨は、**誰もが公平かつアクセスしやすいマイニング** という唯一の目標を掲げて開発されました。

MinersWorldCoin は、一攫千金を狙ったスキームでも、ICOで資金を集めるためのものでもなく、ASIC の遊び場でもありません。 **ICO、プレマイニング、隠れたメリットなどは一切ありません**。CPUを駆使した、誠実なマイニングです。

古いデスクトップ、ホームサーバー、最新のワークステーションなど、どんな環境でも**CPUがあなたのツルハシです**。計算力があれば、マイニングできます。これがMinersWorldCoinの基盤です。アクセシビリティを通じた分散化です。

MinersWorldCoin Coreは、ネットワークのリファレンス実装であり、**yespowerMWC**アルゴリズムによって保護された**レイヤー1ブロックチェーン**を提供します。このアルゴリズムは、ASICによる支配に抵抗し、公平性、分散性、そしてコミュニティ主導のマイニングを維持するために設計されています。

MinersWorldCoinネットワークで使用されるデフォルトの手数料については、[手数料に関する推奨事項](doc/fee-recommendation.md)を参照してください。

**ウェブサイト:** [MinersWorldCoin](https://www.minersworld.org/)

---

## MinersWorldCoin のマイニングワールド 🌐

MinersWorldCoin は、シンプルな原則に基づいて構築されています。
**1つのCPU、1つの発言権**

特殊なハードウェアは不要。内部者による優位性も、中央集権的な発行もありません。コインは、ネットワークに実際の計算作業を提供することで、誰にとっても同じように生成されます。

**主な特徴:**
- **CPUのみのマイニング** — プロセッサを搭載している人なら誰でもアクセス可能
- **ASICマイニングなし** — 産業的な中央集権化を防止
- **ICOなし** — 事前販売なし
- **プレマイニングなし** — ブロック1から公平にローンチ
- **設計による分散化** — 採掘権はマイナーに委ねられる

---

### ビルドターゲット

| プラットフォーム | アーキテクチャ | フォルダ | ステータス |
|--------|--------------|--------|--------|
| Linux | x86_64 | `x86_64-linux` | ![Linux x86_64](https://img.shields.io/badge/Linux-x86__64-success?logo=linux) |
| Linux | i686 | `i686-linux` | ![Linux i686](https://img.shields.io/badge/Linux-i686-success?logo=linux) |
| Linux | ARM64 | `aarch64-linux` | ![Linux ARM64](https://img.shields.io/badge/Linux-ARM64-success?logo=linux) |
| Linux | ARMHF | `armhf-linux` | ![Linux ARMHF](https://img.shields.io/badge/Linux-ARMHF-success?logo=linux) |
| Windows | x86_64 | `x86_64-win` | ![Windows x64](https://img.shields.io/badge/Windows-x86__64-success?logo=windows) |
| Windows | i686 | `i686-win` | ![Windows x86](https://img.shields.io/badge/Windows-i686-success?logo=windows) |
| macOS | Intel | `x86_64-macos` | ![macOS Intel](https://img.shields.io/badge/macOS-Intel-success?logo=apple) |

---

## 本物のマイナーのために構築 ⚙️

MinersWorldCoinは、暗号通貨の黎明期、つまりマイニングが**誰でも**自宅でできるものだった時代にインスピレーションを得ています。Dogecoinの精神に似ていますが、**CPUの公平性**に厳密に焦点を当てています。

GPUが競い合うことも、小規模マイナーを締め出すASICファームもありません。CPUパワーを提供することで、チェーンのセキュリティに貢献し、正当な報酬を得ることができます。

ここでのマイニングは、誰が最大のリグを持っているかということではありません。
参加が重要です。

---

## 使用ガイド 🧭

マイニングまたはノードの実行を開始するには、[インストールガイド](INSTALL.md)と[入門チュートリアル](doc/getting-started.md)に従ってください。

MinersWorldCoin Coreには、フル機能で自己文書化された**JSON-RPC API**が含まれています。
使用方法:

`minersworldcoin-cli help`

より詳細な技術情報については、[Bitcoin Core RPC ドキュメント](https://developer.bitcoin.org/reference/rpc/) を参照してください。MinersWorldCoin も同じ基本標準に準拠しています。

---

### ネットワークポート ⚡

**MinersWorldCoin** ネットワークで使用されるポートは次のとおりです。

| Function | mainnet | testnet | regtest |
| :------- | ------: | ------: | ------: |
| P2P | 4403 | 14403 | 24403 |
| RPC | 5579 | 15579 | 18433 |

⚠️ **セキュリティに関するお知らせ:**
RPC ポートをパブリックインターネットに公開しないでください。RPC アクセスはウォレットとノード操作を制御するため、非公開にする必要があります。

---

## 進行中の開発 🛠️

**MinersWorldCoin Core** は完全にオープンソースで、コミュニティ主導です。開発は透明性が高く、協力的で、マイナーとノードオペレーターのニーズに沿って進められます。

ぜひご参加ください:
- [GitHub プロジェクト](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/projects) — 現在の開発状況と開発計画を追跡できます
- [GitHub ディスカッション](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/discussions) — アイデアや改善点を提案できます
- [MinersW&title=%5Bbug%5D+)。

[貢献ギア](CONTRIBUTING.md) を参照して、すべての情報を共有します。安全な情報を確認し、ドキュメントを閲覧し、**安全に冒険を続けてください**。

---

## アベンチュラのジュンテセ！ 🌟

友人と熱心なコミュニティを共有しましょう。 MinersWorldCoin の世界の冒険、歴史の比較、将来の展望、調査結果を確認してください。

定期的にコミュニティを共有します:
- [Discord](https://discord.gg/5HZGx5bbKK)
- [電報](https://t.me/+0IfF9E76ETZiNDQ8)

---

## ペルグンタス フリクエンテス ❓

テム・デュヴィダス?回答として [Perguntas Frequentes](doc/FAQ.md) [seção de Perguntas e Respostas](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/Discussions/categories/q-a) を参照してください。

---

## ライセンス ⚖️

MinersWorldCoin Core を **Licença MIT** としてご利用ください。

[COPIANDO](COPIANDO) 詳細については、[opensource.org](https://opensource.org/licenses/MIT) にアクセスしてください。

---

🚀 冒険を始めませんか?仮想通貨の世界は、CPU の集中力を低下させます。 🌍
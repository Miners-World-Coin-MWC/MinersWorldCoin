<h1 align="center">
<img src="https://github.com/Miners-World-Coin-MWC/MinersWorldCoin/blob/main/src/qt/res/icons/bitcoin.png" alt="MinersWorldCoin" width="300"/>
<br/><br/>
MinersWorldCoin Core [MWC]
</h1>

Chọn ngôn ngữ: [EN](/README.md) | [CN](./README_zh_CN.md) | [PT](./README_pt_BR.md) | [FA](./README_fa_IR.md) | VI | [JA](./README_ja_JP.md)

![Chỉ dùng CPU](https://img.shields.io/badge/Mining-CPU%20Only-orange)
![Không dùng ASIC](https://img.shields.io/badge/ASIC-Resistant-green)
![Không khai thác trước](https://img.shields.io/badge/Launch-No%20Premine-brightgreen)
![Không ICO](https://img.shields.io/badge/ICO-None-red)

## Chào mừng, người khai thác! ⛏️
Chào mừng đến với **MinersWorldCoin**, một loại tiền điện tử được tạo ra với một mục tiêu duy nhất: **khai thác công bằng, dễ tiếp cận cho tất cả mọi người**.

MinersWorldCoin không phải là một kế hoạch làm giàu nhanh chóng, không phải là một chiêu trò kiếm tiền bằng ICO, và không phải là sân chơi ASIC. Không có **ICO, không có khai thác trước, và không có lợi thế ẩn** — chỉ là khai thác trung thực, được hỗ trợ bởi CPU.

Cho dù bạn đang sử dụng máy tính để bàn cũ, máy chủ gia đình hay máy trạm hiện đại, **CPU của bạn chính là công cụ khai thác**. Nếu bạn có khả năng tính toán, bạn có thể khai thác. Đó là nền tảng của MinersWorldCoin: phân quyền thông qua khả năng tiếp cận.

MinersWorldCoin Core là phiên bản tham chiếu của mạng lưới, cung cấp một **blockchain Lớp 1** được bảo mật bởi thuật toán **yespowerMWC** — được thiết kế để chống lại sự thống trị của ASIC và giữ cho hoạt động khai thác công bằng, phân tán và do cộng đồng điều khiển.

Để biết thông tin về phí mặc định được sử dụng trên mạng MinersWorldCoin, vui lòng tham khảo [khuyến nghị phí](doc/fee-recommendation.md).

**Trang web:** [MinersWorldCoin](https://www.minersworld.org/)

---

## Thế giới khai thác của MinersWorldCoin 🌐

MinersWorldCoin được xây dựng dựa trên một nguyên tắc đơn giản:
**một CPU, một tiếng nói.**

Không cần phần cứng chuyên dụng. Không có lợi thế nội bộ. Không có phát hành tập trung. Tiền được tạo ra theo cùng một cách cho tất cả mọi người — bằng cách đóng góp công việc tính toán thực tế vào mạng lưới.

**Các tính năng chính:**
- **Khai thác chỉ bằng CPU** — Bất kỳ ai có bộ xử lý đều có thể truy cập được
- **Không khai thác ASIC** — Ngăn chặn sự tập trung hóa công nghiệp
- **Không ICO** — Không có nguồn cung bán trước
- **Không khai thác trước** — Khởi chạy công bằng từ khối đầu tiên
- **Phi tập trung theo thiết kế** — Quyền lực nằm trong tay người khai thác

---

### Mục tiêu xây dựng

| Nền tảng | Kiến trúc | Thư mục | Trạng thái |

|--------|--------------|--------|--------|

| Linux | x86_64 | `x86_64-linux` | ![Linux x86_64](https://img.shields.io/badge/Linux-x86__64-success?logo=linux) |
| Linux | i686 | `i686-linux` | ![Linux i686](https://img.shields.io/badge/Linux-i686-success?logo=linux) |

| Linux | ARM64 | `aarch64-linux` | ![Linux ARM64](https://img.shields.io/badge/Linux-ARM64-success?logo=linux) |

| Linux | ARMHF | `armhf-linux` | ![Linux ARMHF](https://img.shields.io/badge/Linux-ARMHF-success?logo=linux) |

| Windows | x86_64 | `x86_64-win` | ![Windows x64](https://img.shields.io/badge/Windows-x86__64-success?logo=windows) |

| Windows | i686 | `i686-win` | ![Windows x86](https://img.shields.io/badge/Windows-i686-success?logo=windows) |

| macOS | Intel | `x86_64-macos` | ![macOS Intel](https://img.shields.io/badge/macOS-Intel-success?logo=apple) |

---

## Được xây dựng cho những người khai thác thực thụ ⚙️

MinersWorldCoin lấy cảm hứng từ những ngày đầu của tiền điện tử — khi khai thác là điều mà **bất cứ ai** cũng có thể làm tại nhà. Giống như Dogecoin về tinh thần, nhưng tập trung nghiêm ngặt vào **sự công bằng về CPU**.

Không có GPU nào vượt lên trước, không có các trang trại ASIC nào chèn ép những người khai thác nhỏ. Nếu bạn đóng góp sức mạnh xử lý CPU, bạn đang góp phần vào tính bảo mật của chuỗi khối — và bạn xứng đáng nhận được phần của mình một cách chính đáng.

Việc khai thác ở đây không phải là về việc ai có dàn máy mạnh nhất.

Mà là về sự tham gia.

---

## Hướng dẫn sử dụng 🧭

Để bắt đầu khai thác hoặc chạy một node, hãy làm theo [hướng dẫn cài đặt](INSTALL.md) và [hướng dẫn bắt đầu](doc/getting-started.md).

MinersWorldCoin Core bao gồm một **API JSON-RPC** đầy đủ tính năng và tự tài liệu hóa.

Sử dụng:

`minersworldcoin-cli help`

Để tham khảo kỹ thuật chuyên sâu hơn, [tài liệu Bitcoin Core RPC](https://developer.bitcoin.org/reference/rpc/) được áp dụng, vì MinersWorldCoin tuân theo các tiêu chuẩn cơ bản tương tự.

---

### Cổng mạng ⚡

Các cổng này được mạng **MinersWorldCoin** sử dụng:

| Chức năng | mainnet | testnet | regtest |

| :------- | ------: | ------: | ------: |

| P2P | 4403 | 14403 | 24403 |

| RPC | 5579 | 15579 | 18433 |

⚠️ **Thông báo bảo mật:**
Không được để lộ các cổng RPC ra internet công cộng. Quyền truy cập RPC kiểm soát ví và hoạt động của node và nên được giữ bí mật.

---

## Phát triển liên tục 🛠️

**MinersWorldCoin Core** hoàn toàn là mã nguồn mở và do cộng đồng điều khiển. Quá trình phát triển minh bạch, hợp tác và được hướng dẫn bởi nhu cầu của người khai thác và người vận hành node.

Tham gia:

- [Dự án GitHub](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/projects) — Theo dõi quá trình phát triển hiện tại và kế hoạch
- [Thảo luận GitHub](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/discussions) — Đề xuất ý tưởng và cải tiến
- [Cộng đồng Reddit MinersWorldCoin](https://www.reddit.com/r/MinersWorldCoin/) — Thảo luận và cập nhật cộng đồng

---

### Phiên bản và Nhánh 🧱

Phiên bản được đánh số theo định dạng **chính.phụ.bản vá**.

Cấu trúc nhánh:

- **master** — Phiên bản ổn định mới nhất
- **maintenance** — Các phiên bản trước đó đang được bảo trì
- **development** — Phát triển tích cực và các tính năng mới

Quy trình đóng góp:

- **Tính năng mới** → `development`

- **Sửa lỗi** → `maintenance`

---

## Đóng góp 🤝

MinersWorldCoin được xây dựng bởi cộng đồng của nó. Nếu bạn khai thác, vận hành hoặc tin tưởng vào tiền điện tử công bằng — bạn đã là một phần của dự án.

Bạn có thể giúp đỡ bằng cách:

- Báo cáo lỗi
- Đề xuất cải tiến
- Gửi yêu cầu kéo (pull request)

Bắt đầu từ đây:

👉 [Trình theo dõi sự cố](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5Bbug%5D+)

Xem [hướng dẫn đóng góp](CONTRIBUTING.md) để biết chi tiết đầy đủ.

---

## Tham gia cộng đồng 🌍

Khai thác cùng nhau sẽ tốt hơn. Kết nối với những người khai thác, nhà phát triển và người ủng hộ khác để chia sẻ kiến ​​thức, cập nhật và tiến độ.

- [Discord](https://discord.gg/5HZGx5bbKK)

- [Telegram](https://t.me/+0IfF9E76ETZiNDQ8)

---

## Câu hỏi thường gặp ❓

Nhiều câu hỏi thường gặp đã được trả lời trong [FAQ](doc/FAQ.md) hoặc trong [phần Hỏi & Đáp](https://github.com/MinersWorldCoin-MWC/MinersWorldCoin/discussions/categories/q-a).

---

## Giấy phép ⚖️

MinersWorldCoin Core được phát hành theo **Giấy phép MIT**.

Xem [COPYING](COPYING) hoặc truy cập [opensource.org](https://opensource.org/licenses/MIT).

---

⛏️ **Sẵn sàng khai thác?**
Hãy cắm CPU của bạn, hỗ trợ phi tập trung hóa và giúp bảo mật mạng lưới — từng hash một.
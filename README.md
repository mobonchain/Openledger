 <h1 align="center">Hi 👋, I'm Mob</h1>
<h3 align="center">Join the Cryptocurrency Market, make money from Airdrop - Retroactive with me</h3>

- <p align="left"> <img src="https://komarev.com/ghpvc/?username=mobonchain&label=Profile%20views&color=0e75b6&style=flat" alt="mobonchain" /> <a href="https://github.com/mobonchain"> <img src="https://img.shields.io/github/followers/mobonchain?label=Follow&style=social" alt="Follow" /> </a> </p>

- [![TopAME | Bullish - Cheerful](https://img.shields.io/badge/TopAME%20|%20Bullish-Cheerful-blue?logo=telegram&style=flat)](https://t.me/xTopAME)

# Hướng Dẫn Cài Đặt Node OpenLedger trên VPS Linux (Ubuntu)

## Chuẩn Bị
- VPS tối thiểu **4 vCPU** và **6 GB RAM**.
- Bạn có thể mua VPS từ **[Contabo](https://contabo.com/en/)**.
  
## Các Bước Tiến Hành

### 1. Đăng Ký Tài Khoản **[OpenLedger](https://testnet.openledger.xyz/?referral_code=vlxbwovzpi)** với tài khoản **Google**.

### 2. Mở VPS lên và nhập lệnh sau để tải Docker và mở Port 3389 trong Firewall:
```bash
wget -qO- https://raw.githubusercontent.com/mobonchain/Openledger/refs/heads/main/openledger.sh | sh
```

- Chờ đợi quá trình cài đặt hoàn tất (mất từ 5 - 10 phút).

- Sau khi cài đặt xong, script sẽ hiển thị thông tin **IP** và **username** (mặc định là `root`) để bạn đăng nhập.

- Mở **Remote Desktop Connection** trên **Windows** hoặc **Microsoft Remote Desktop** trên **macOS**.

- Nhập địa chỉ IP vào ô **Computer**, rồi nhấn **Connect**.

- Khi được yêu cầu, nhập thông tin đăng nhập:
- **Username**: `root`
- **Mật khẩu**: Mật khẩu bạn đã tạo khi mua VPS Linux.

Nhấn **Enter** để vào giao diện chính.

### 3. Mở **Terminal** trên giao diện RDP và thực hiện các lệnh sau:
- Tải **OpenLedger Node Package**:
  ```bash
  wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip
  ```
- Giải nén tệp đã tải về:
  ```bash
  unzip openledger-node-1.0.0-linux.zip
  ```
- Cài đặt OpenLedger Node:
  ```bash
  sudo dpkg -i openledger-node-1.0.0.deb
  ```
- Chạy OpenLedger Node:
  ```bash
  openledger-node --no-sandbox
  ```

### 4. Cửa sổ OpenLedger sẽ hiện ra. Đăng nhập bằng tài khoản Google đã đăng ký trước đó.

### 5. Chọn **Continue Setup Node** và nhấn **Connect** để hoàn tất quá trình cài đặt.

---

Chúc bạn cài đặt thành công. Và đây là **Mob** - **[TopAME | Bullish - Cheerful](https://t.me/xTopAME)**

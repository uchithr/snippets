# qBittorrent-nox Installation Guide for AlmaLinux 10

**Version**: 1.0  
**Date**: July 14, 2025  
**Description**: A comprehensive guide to install `qbittorrent-nox` on AlmaLinux 10, covering dependency installation, source compilation, error handling, and systemd service setup.  
**Estimated Time**: ~30 minutes (vs. 4 hours without a guide)  
**Author**: Grok 3, xAI

## Prerequisites
- **OS**: AlmaLinux 10
- **User**: Must have `sudo` privileges
- **Internet**: Required for package downloads and Git cloning
- **Disk Space**: At least 2GB free for source code and compilation
- **Memory**: 4GB RAM recommended for compilation

---

## 1. Install Development Tools and Dependencies

**Description**: Install necessary tools and libraries for building `qbittorrent-nox` and `libtorrent-rasterbar`.

**Commands**:
```bash
sudo dnf install -y epel-release
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y cmake gcc gcc-c++ ninja-build qt5-qtbase-devel qt5-qttools-devel openssl-devel zlib-ng-compat-devel zlib-ng-compat-static boost-devel
```

**Error Handling**:
- **Error**: `No match for argument: <package>`
  - **Solution**:
    - Ensure EPEL is enabled: `sudo dnf install -y epel-release`
    - Check internet: `ping -c 4 google.com`
    - Update metadata: `sudo dnf update`
    - If `libtorrent-rasterbar-devel` is unavailable, proceed to build from source (Step 2).
- **Error**: `Permission denied`
  - **Solution**: Run commands with `sudo` or as root.

**Verification**:
```bash
dnf list installed | grep -E "cmake|gcc|qt5|openssl|zlib|boost"
```
- **Expected Output**: Lists installed packages (e.g., `cmake`, `gcc`, `qt5-qtbase-devel`).
- **Failure Action**: Re-run installation for missing packages.

---

## 2. Build libtorrent-rasterbar from Source

**Description**: Since `libtorrent-rasterbar-devel` is not in AlmaLinux 10 repositories, build it from source (version 2.0.11 for qBittorrent 5.x compatibility).

**Commands**:
```bash
cd ~/Applications
git clone https://github.com/arvidn/libtorrent.git || echo "libtorrent directory already exists, skipping clone"
cd libtorrent
git checkout v2.0.11
mkdir -p build && cd build
sudo rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DZLIB_ROOT=/usr/local/zlib \
      -DZLIB_INCLUDE_DIR=/usr/local/zlib/include \
      -DZLIB_LIBRARY=/usr/local/zlib/lib/libz.a \
      -DOPENSSL_INCLUDE_DIR=/usr/include/openssl \
      -DOPENSSL_SSL_LIBRARY=/usr/lib64/libssl.so \
      -DOPENSSL_CRYPTO_LIBRARY=/usr/lib64/libcrypto.so ..
make -j$(nproc)
sudo make install
sudo ldconfig
```

**Error Handling**:
- **Error**: `fatal: destination path 'libtorrent' already exists`
  - **Solution**: Skip cloning: `cd ~/Applications/libtorrent`
- **Error**: `CMake Error: The source directory ... does not contain CMakeLists.txt`
  - **Solution**: Ensure you’re in `~/Applications/libtorrent/build` and run `cmake ..`
- **Error**: `No rule to make target`
  - **Solution**:
    - Clear build directory: `sudo rm -rf ~/Applications/libtorrent/build/*`
    - Re-run `cmake` and `make`.
- **Error**: Missing dependencies (e.g., boost, openssl)
  - **Solution**: Install missing dependencies: `sudo dnf install -y boost-devel openssl-devel zlib-ng-compat-devel`

**Verification**:
```bash
ls -l /usr/local/lib64/libtorrent-rasterbar.so.2.0
ls -l /usr/local/include/libtorrent/torrent.hpp
ls -l /usr/local/lib64/cmake/LibtorrentRasterbar/LibtorrentRasterbarConfig.cmake
```
- **Expected Output**:
  - Library: `-rwxr-xr-x ... libtorrent-rasterbar.so.2.0`
  - Header: `-rw-r--r-- ... torrent.hpp`
  - CMake config: `-rw-r--r-- ... LibtorrentRasterbarConfig.cmake`
- **Failure Action**: Re-run `sudo make install`.

---

## 3. Build qBittorrent-nox from Source

**Description**: Build and install `qbittorrent-nox` using the installed `libtorrent-rasterbar`.

**Commands**:
```bash
cd ~/Applications
git clone https://github.com/qbittorrent/qBittorrent.git || echo "qBittorrent directory already exists, skipping clone"
cd qBittorrent/build
sudo rm -rf *
cmake -DGUI=OFF -DCMAKE_BUILD_TYPE=Release \
      -DOPENSSL_INCLUDE_DIR=/usr/include/openssl \
      -DOPENSSL_SSL_LIBRARY=/usr/lib64/libssl.so \
      -DOPENSSL_CRYPTO_LIBRARY=/usr/lib64/libcrypto.so \
      -DLibtorrentRasterbar_DIR=/usr/local/lib64/cmake/LibtorrentRasterbar ..
make -j$(nproc)
sudo make install
```

**Error Handling**:
- **Error**: `CMake Error at /usr/lib64/cmake/ZLIB/ZLIB.cmake:84 (message): The imported target 'ZLIB::zlibstatic' references the file '/usr/lib64/libz.a'`
  - **Solution**:
    - Install system static ZLIB: `sudo dnf install -y zlib-ng-compat-static`
    - Alternatively, use custom ZLIB:
      ```bash
      cmake -DGUI=OFF -DCMAKE_BUILD_TYPE=Release \
            -DZLIB_ROOT=/usr/local/zlib \
            -DZLIB_INCLUDE_DIR=/usr/local/zlib/include \
            -DZLIB_LIBRARY=/usr/local/zlib/lib/libz.a \
            -DOPENSSL_INCLUDE_DIR=/usr/include/openssl \
            -DOPENSSL_SSL_LIBRARY=/usr/lib64/libssl.so \
            -DOPENSSL_CRYPTO_LIBRARY=/usr/lib64/libcrypto.so \
            -DLibtorrentRasterbar_DIR=/usr/local/lib64/cmake/LibtorrentRasterbar \
            -DZLIB_USE_STATIC_LIBS=ON \
            -DCMAKE_IGNORE_PATH=/usr/lib64/cmake/ZLIB ..
      ```
- **Error**: `No rule to make target`
  - **Solution**: Clear build directory: `sudo rm -rf ~/Applications/qBittorrent/build/*` and re-run `cmake`.
- **Error**: `libtorrent-rasterbar not found`
  - **Solution**: Verify `libtorrent-rasterbar` installation (Step 2) and check `/usr/local/lib64/cmake/LibtorrentRasterbar`.

**Verification**:
```bash
ls -l /usr/local/bin/qbittorrent-nox
qbittorrent-nox --version
```
- **Expected Output**:
  - Binary: `-rwxr-xr-x ... qbittorrent-nox`
  - Version: `qBittorrent 5.0.0` (or similar)
- **Failure Action**: Check for runtime library errors (Step 4).

---

## 4. Fix Runtime Library Path

**Description**: Ensure the dynamic linker finds `libtorrent-rasterbar.so.2.0` in `/usr/local/lib64`.

**Commands**:
```bash
sudo sh -c 'echo "/usr/local/lib64" > /etc/ld.so.conf.d/libtorrent-rasterbar.conf'
sudo ldconfig
```

**Error Handling**:
- **Error**: `qbittorrent-nox: error while loading shared libraries: libtorrent-rasterbar.so.2.0: cannot open shared object file`
  - **Solution**:
    - Verify library: `ls -l /usr/local/lib64/libtorrent-rasterbar.so.2.0`
    - Re-run `sudo ldconfig`.
    - Alternatively, set temporary path: `export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH`
    - If missing, rebuild `libtorrent-rasterbar` (Step 2).

**Verification**:
```bash
ldconfig -p | grep libtorrent-rasterbar
qbittorrent-nox --version
```
- **Expected Output**:
  - Library: Lists `libtorrent-rasterbar.so.2.0` in `/usr/local/lib64`
  - Version: `qBittorrent 5.0.0` (or similar)
- **Failure Action**: Check `ldd /usr/local/bin/qbittorrent-nox` for missing libraries.

---

## 5. Configure qBittorrent-nox as a Systemd Service

**Description**: Set up `qbittorrent-nox` to run as a systemd service for automatic startup.

**Commands**:
```bash
sudo nano /etc/systemd/system/qbittorrent-nox.service
```

Paste into the file:
```ini
[Unit]
Description=qBittorrent-nox Daemon
After=network.target

[Service]
User=sam
Group=sam
Environment="LD_LIBRARY_PATH=/usr/local/lib64"
ExecStart=/usr/local/bin/qbittorrent-nox
Restart=always

[Install]
WantedBy=multi-user.target
```

Continue:
```bash
sudo systemctl daemon-reload
sudo systemctl enable qbittorrent-nox
sudo systemctl start qbittorrent-nox
```

**Error Handling**:
- **Error**: `Failed to start qbittorrent-nox.service`
  - **Solution**:
    - Check status: `sudo systemctl status qbittorrent-nox`
    - Verify binary: `ls -l /usr/local/bin/qbittorrent-nox`
    - Check logs: `journalctl -u qbittorrent-nox`
    - Ensure `LD_LIBRARY_PATH` is set if needed (Step 4).
- **Error**: `Permission denied`
  - **Solution**: Ensure user `sam` has permissions or use `sudo`.

**Verification**:
```bash
sudo systemctl status qbittorrent-nox
```
- **Expected Output**: Shows `active (running)`
- **Failure Action**: Check logs: `journalctl -u qbittorrent-nox`

---

## 6. Access qBittorrent Web UI

**Description**: Access the qBittorrent Web UI and secure the default credentials.

**Instructions**:
- Open a browser and navigate to `http://localhost:8080`.
- Log in with:
  - **Username**: `admin`
  - **Password**: `adminadmin`
- Go to **Tools > Options > Web UI** and change the password.

**Commands**:
```bash
echo "Access Web UI at http://localhost:8080"
echo "Default credentials: Username: admin, Password: adminadmin"
```

**Error Handling**:
- **Error**: Unable to access Web UI
  - **Solution**:
    - Ensure service is running: `sudo systemctl status qbittorrent-nox`
    - Check port 8080: `ss -tuln | grep 8080`
    - Open firewall: `sudo firewall-cmd --add-port=8080/tcp --permanent && sudo firewall-cmd --reload`
    - Check logs: `journalctl -u qbittorrent-nox`
- **Error**: Invalid username or password
  - **Solution**:
    - Reset password by editing `~/.config/qBittorrent/qBittorrent.ini`:
      ```bash
      nano ~/.config/qBittorrent/qBittorrent.ini
      ```
      - Remove `Password=` line under `[WebUI]` and restart: `sudo systemctl restart qbittorrent-nox`

**Verification**:
```bash
curl -I http://localhost:8080
```
- **Expected Output**: `HTTP/1.1 200 OK` or `401 Unauthorized` (indicating Web UI is active)
- **Failure Action**: Ensure service is running and port is open.

---

## 7. Alternative: Docker Installation

**Description**: Use Docker for a quicker, isolated `qbittorrent-nox` setup if source compilation fails.

**Commands**:
```bash
sudo dnf install -y docker
sudo systemctl start docker
sudo docker run -d --name qbittorrent -p 8080:8080 -v /path/to/downloads:/downloads linuxserver/qbittorrent
```

**Error Handling**:
- **Error**: `docker: command not found`
  - **Solution**: Install Docker: `sudo dnf install -y docker`
- **Error**: `Cannot connect to the Docker daemon`
  - **Solution**: Start Docker: `sudo systemctl start docker`
- **Error**: `Port already in use`
  - **Solution**: Stop conflicting service or change port: `sudo docker run -d --name qbittorrent -p 8081:8080 ...`

**Verification**:
```bash
docker ps
```
- **Expected Output**: Lists `qbittorrent` container as running
- **Failure Action**: Check logs: `docker logs qbittorrent`

---

## Notes

- **Compatibility**:
  - Use `libtorrent-rasterbar` 2.0.11 for qBittorrent 5.x compatibility.
  - Use the latest stable qBittorrent version from GitHub.
- **Warnings**:
  - `QNetworkConfigurationManager` deprecated Qt warnings during compilation are safe to ignore.
- **Security**:
  - Change the default Web UI password (`admin/adminadmin`) immediately.
  - Restrict Web UI access with firewall rules if exposed to a network.
- **Troubleshooting**:
  - Check runtime dependencies: `ldd /usr/local/bin/qbittorrent-nox`
  - Verify library paths: `ldconfig -p | grep libtorrent`
  - Use verbose CMake output: Add `-DVERBOSE_CONFIGURE=ON` to `cmake` commands.
- **Cleanup**:
  - Remove build directories to save space:
    ```bash
    rm -rf ~/Applications/libtorrent/build/* ~/Applications/qBittorrent/build/*
    ```
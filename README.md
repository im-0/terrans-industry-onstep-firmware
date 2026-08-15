# Unofficial firmware update for Terrans Industry Onstep V5 Pro for EQ5 mount

## How to flash

```bash
#TODO
```

## How to build

```bash
# Install prerequisites
sudo ./1-install-arduino-cli.sh
./2-install-esp-toolchains.sh
./3-install-arduino-libs.sh

# Terrans Industry Onstep Goto Controller V5 Pro: primary OnStepX firmware, tracking and Bluetooth
4-build-onstepx.sh
# Terrans Industry Onstep Goto Controller V5 Pro: WiFi and web interface
6-build-smartwebserver.sh

# Terrans Industry Smart Hand Controller (SHC)
5-build-smarthandcontroller.sh

# List firmware files
ls -lh */build/*/*.ino.bin
```

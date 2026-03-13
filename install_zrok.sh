# install_zrok.sh

```bash
#!/usr/bin/env bash

set -e

ZROK_VERSION="1.1.11"
DOWNLOAD_URL="https://github.com/openziti/zrok/releases/download/v${ZROK_VERSION}/zrok_${ZROK_VERSION}_linux_amd64.tar.gz"

echo "==========================================="
echo "        ZROK INSTALLATION SCRIPT"
echo "==========================================="

echo "Checking dependencies..."
command -v wget >/dev/null 2>&1 || { echo "wget not found. Installing..."; sudo apt update && sudo apt install -y wget; }
command -v tar >/dev/null 2>&1 || { echo "tar not found. Installing..."; sudo apt update && sudo apt install -y tar; }

echo ""
echo "Downloading zrok v${ZROK_VERSION}..."

wget -q --show-progress $DOWNLOAD_URL -O zrok.tar.gz

echo ""
echo "Extracting archive..."

tar -xvzf zrok.tar.gz

echo ""
echo "Installing zrok..."

sudo mv zrok /usr/local/bin/
sudo chmod +x /usr/local/bin/zrok

echo ""
echo "Verifying installation..."

zrok version

echo ""
echo "Cleaning up..."

rm -f zrok.tar.gz CHANGELOG.md LICENSE README.md 2>/dev/null || true

echo ""
echo "==========================================="
echo "        ZROK INSTALLED SUCCESSFULLY"
echo "==========================================="

if [ -n "$1" ]; then
    echo ""
    echo "Enabling zrok environment..."
    zrok enable "$1"
    echo ""
    echo "Environment enabled successfully!"
else
    echo ""
    echo "To enable zrok environment run:"
    echo ""
    echo "zrok enable <YOUR_TOKEN>"
fi

echo ""
echo "Example to share localhost:"
echo ""
echo "zrok share public 8000"
echo ""
echo "Done!"
```

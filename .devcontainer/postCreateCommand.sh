#!/bin/bash
set -ex

# Download and configure Checkstyle
CHECKSTYLE_VERSION="10.21.4"
CHECKSTYLE_DIR="/home/vscode/.checkstyle"
mkdir -p $CHECKSTYLE_DIR

# Download the latest Checkstyle
echo "Downloading Checkstyle ${CHECKSTYLE_VERSION}"
curl -L -o $CHECKSTYLE_DIR/checkstyle-${CHECKSTYLE_VERSION}-all.jar \
  https://github.com/checkstyle/checkstyle/releases/download/checkstyle-${CHECKSTYLE_VERSION}/checkstyle-${CHECKSTYLE_VERSION}-all.jar

echo "Checkstyle setup completed"

# Check versions
echo "Checking versions"
java -version

# Verify Checkstyle version
ls -la /home/vscode/.checkstyle
echo "Checkstyle version:"
java -jar $CHECKSTYLE_DIR/checkstyle-${CHECKSTYLE_VERSION}-all.jar --version

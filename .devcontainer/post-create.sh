#!/bin/bash

REPO_NAME=$1
ZEPHYR_BRANCH=$2

set -e

# Enter workspace
cd /workspace

# Setup VS Code
if [ ! -d ".vscode" ]; then
    ln -s $REPO_NAME/.vscode
fi

# Create Python venv
if [ ! -d ".venv" ]; then
    python -mvenv .venv
fi
. .venv/bin/activate
pip install --upgrade pip
pip install west

# Setup Zephyr
if [ ! -d ".west" ]; then
	west init -m https://github.com/zephyrproject-rtos/zephyr --mr $ZEPHYR_BRANCH
fi

west update

pip install -r zephyr/scripts/requirements.txt

echo ". /workspace/zephyr/zephyr-env.sh" >> ~/.bashrc

# Put clangd files in expected positions
if [ ! -f ".clangd" ]; then
    ln -s $REPO_NAME/.clangd
fi

if [ ! -f ".clang-format" ]; then
    ln -s zephyr/.clang-format
fi

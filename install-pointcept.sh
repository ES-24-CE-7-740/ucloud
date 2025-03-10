#!/bin/bash

# This script installs Pointcept repo with CUDA 11.8, pytorch 2.1.0, Miniconda and flash-attention.
echo "Starting installation..."
git clone https://github.com/ES-25-CE-8-846/ucloud.git

echo "Creating installation script..."
cat ucloud/install-scripts/cuda-toolkit-118.sh >> install-script.sh
echo "
" >> install-script.sh

cat ucloud/install-scripts/miniconda.sh >> install-script.sh
echo "
" >> install-script.sh

cat ucloud/install-scripts/pointcept-cu118.sh >> install-script.sh
echo "
" >> install-script.sh

echo "Running install-script.sh..."
sh install-script.sh
rm install-script.sh

# Set .bashrc settings
echo "
# Automatically activate pointcept environment
conda activate pointcept
" >> $HOME/.bashrc

echo "
# Automatically start a specific tmux session if not already in one
if [ "$TERM_PROGRAM" = tmux ]; then
  tmux
fi
" >> $HOME/.bashrc

echo "Installation completed successfully."
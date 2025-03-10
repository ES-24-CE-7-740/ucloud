#!/bin/bash

set -e  # Exit on error

# This script installs CUDA Toolkit 11.8
mkdir -p $HOME/cuda
cd $HOME/cuda

# Download the CUDA Toolkit installer
# The -q option suppresses the progress bar and other output

# check if installer already exists
if [ -f "/work/3dgs-drive/cuda_11.8.0_520.61.05_linux.run" ]; then
    echo "CUDA Toolkit installer already exists. Skipping download."
    installer_path="/work/3dgs-drive/cuda_11.8.0_520.61.05_linux.run"
else
    echo "CUDA Toolkit installer not found. Downloading..."
    wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run -q
    installer_path="cuda_11.8.0_520.61.05_linux.run"
fi

# Check md5sum of the installer to avoid corrupted installer
# The expected md5sum for the installer is "d6cf26349e5a4104b8683e26b717fa22 cuda_11.8.0_520.61.05_linux.run"
echo "Checking MD5 checksum..."
if [ "$(md5sum $installer_path | awk '{ print $1 }')" != "d6cf26349e5a4104b8683e26b717fa22" ]; then
    echo "MD5 checksum does not match. Exiting."
    exit 1
fi
echo "MD5 checksum matches."

# Run the installer
# The --silent option suppresses the installer GUI
# The --toolkit option installs the CUDA Toolkit
# The --toolkitpath option specifies the installation directory
echo "Installing CUDA Toolkit..."
sh $installer_path --silent --toolkit --toolkitpath=$HOME/cuda/11.8
echo "CUDA Toolkit installed successfully."

# Add environment variables to .bashrc
echo "Setting environment variables..."
echo "export CUDA_HOME=$HOME/cuda/11.8" >> $HOME/.bashrc
echo "export PATH=\$CUDA_HOME/bin:\$PATH" >> $HOME/.bashrc
echo "export LD_LIBRARY_PATH=\$CUDA_HOME/lib64:\$LD_LIBRARY_PATH" >> $HOME/.bashrc
. $HOME/.bashrc

nvcc --version
echo "CUDA Toolkit installation completed."


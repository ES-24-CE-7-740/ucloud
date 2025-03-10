#!/bin/bash

set -e  # Exit on error

# Set Conda installation path
CONDA_DIR="$HOME/miniconda3"
CONDA_BIN="$CONDA_DIR/bin/conda"

# Check if Conda is installed
if ! command -v conda &> /dev/null; then
    echo "Conda not found. Installing Miniconda..."
    
    # Download & install Miniconda
    MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
    curl -O https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER
    bash $MINICONDA_INSTALLER -b -p $CONDA_DIR
    rm $MINICONDA_INSTALLER
    
    # Initialize Conda
    eval "$($CONDA_BIN shell.bash hook)"
    $CONDA_BIN init bash
    export PATH="$CONDA_DIR/bin:$PATH"
else
    echo "Conda already installed."
fi

# Ensure Conda is accessible
echo "export PATH=\"$CONDA_DIR/bin:\$PATH\"" >> $HOME/.bashrc
source $HOME/.bashrc
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
export PATH="$CONDA_DIR/bin:$PATH"

# Set CUDA architecture for H100 (Compute Capability 9.0)¨
export TORCH_CUDA_ARCH_LIST="9.0"

# Install pointcept
git clone https://github.com/Pointcept/Pointcept.git
cd Pointcept

conda create -n pointcept python=3.8
conda activate pointcept

conda install ninja
conda install pytorch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 pytorch-cuda=11.8 -c pytorch -c nvidia
conda install h5py pyyaml -c anaconda
conda install sharedarray tensorboard tensorboardx yapf addict einops scipy plyfile termcolor timm -c conda-forge
conda install pytorch-cluster pytorch-scatter pytorch-sparse -c pyg
pip install torch-geometric

pip install spconv-cu118

pip install ftfy regex tqdm
pip install git+https://github.com/openai/CLIP.git

cd libs/pointops
TORCH_CUDA_ARCH_LIST="9.0" python setup.py install
cd ../..

#pip install open3d

# Install flash-attention
pip install packaging
pip install flash-attn --no-build-isolation

# Clean cache
conda clean -a -y
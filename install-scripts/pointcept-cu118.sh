#!/bin/bash

set -e  # Exit on error

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

# Install flash-attention
pip install packaging
pip install flash-attn --no-build-isolation

# Clean cache
conda clean -a -y
#!/bin/bash

set -e  # Exit on error

# Install pointcept
git clone https://github.com/Pointcept/Pointcept.git
cd Pointcept

conda create -n pointcept python=3.9
conda activate pointcept

conda install ninja
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
conda install h5py pyyaml -c anaconda
conda install sharedarray tensorboard tensorboardx yapf addict einops scipy plyfile termcolor timm -c conda-forge
conda install pytorch-cluster pytorch-scatter pytorch-sparse -c pyg
pip install torch-geometric

pip install spconv-cu120

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
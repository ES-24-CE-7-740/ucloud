#!/bin/bash

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

echo "conda activate pointcept" >> $HOME/.bashrc

echo "Installation completed successfully."
#!/bin/bash

set -e  # Exit on error

sh install-scripts/cuda-toolkit-118.sh
sh install-scripts/miniconda.sh
sh install-scripts/pointcept-cu118.sh

# Clean cache
conda clean -a -y
echo "Installation completed successfully."
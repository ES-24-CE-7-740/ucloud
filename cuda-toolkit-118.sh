# This script installs CUDA Toolkit 11.8
mkdir -p $HOME/cuda
cd $HOME/cuda

# Download the CUDA Toolkit installer
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run

# Check md5sum of the installer to avoid corrupted installer
# The expected md5sum for the installer is "d6cf26349e5a4104b8683e26b717fa22 cuda_11.8.0_520.61.05_linux.run"
echo "Checking MD5 checksum..."
if [ "$(md5sum cuda_11.8.0_520.61.05_linux.run | awk '{ print $1 }')" != "d6cf26349e5a4104b8683e26b717fa22" ]; then
    echo "MD5 checksum does not match. Exiting."
    exit 1
fi
echo "MD5 checksum matches."

# Run the installer
# The --silent option suppresses the installer GUI
# The --toolkit option installs the CUDA Toolkit
# The --toolkitpath option specifies the installation directory
echo "Installing CUDA Toolkit..."
sh cuda_11.8.0_520.61.05_linux.run --silent --toolkit --toolkitpath=$HOME/cuda/11.8
echo "CUDA Toolkit installed successfully."

# # Set environment variables
# export CUDA_HOME=$HOME/cuda/11.8
# export PATH=$CUDA_HOME/bin:$PATH
# export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# Add environment variables to .bashrc
echo "Setting environment variables..."
echo "export CUDA_HOME=$HOME/cuda/11.8" >> ~/.bashrc
echo "export PATH=\$CUDA_HOME/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$CUDA_HOME/lib64:\$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc
bash

echo "CUDA Toolkit installation completed."


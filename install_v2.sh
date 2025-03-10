#!/bin/bash

git clone https://github.com/ES-25-CE-8-846/ucloud.git


cat ucloud/install-scripts/cuda-toolkit-118.sh >> install-script.sh
echo "
" >> install-script.sh

cat ucloud/install-scripts/miniconda.sh >> install-script.sh
echo "
" >> install-script.sh

cat ucloud/install-scripts/pointcept-cu118.sh >> install-script.sh
echo "
" >> install-script.sh

sh install-script.sh
rm install-script.sh

echo "Installation completed successfully."
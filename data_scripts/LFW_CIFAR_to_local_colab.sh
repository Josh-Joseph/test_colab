#!/bin/bash

echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Launching script."
echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Executing download_lfw_raw.sh"
. ./test_colab/data_scripts/download_lfw_raw.sh

echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Executing flatten_lfw_raw.sh"
echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
. ./test_colab/data_scripts/flatten_lfw_raw.sh

echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Executing download_cifar-10.sh"
echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
. ./test_colab/data_scripts/download_cifar-10.sh

echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Executing unpickle_cifar-10.py"
echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
python ./test_colab/data_scripts/unpickle_cifar-10.py

echo -e "\n *~*~*~*~*~*~*~*~*~*"
echo -e "\n Cleaning up ./raw_data"
echo -e "\n *~*~*~*~*~*~*~*~*~*"
rm -rf ./raw_data/cifar-10-batches-py

echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Packaging the raw_data into dataset/train and dataset/dev"
echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
python ./data_scripts/package_into_train_dev.py

echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
echo -e "\n Done!"
echo -e "\n *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"

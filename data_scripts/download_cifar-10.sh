:'This downloads the Python version of CIFAR-10.
'

# Run this script for the root of this repository.
if [ ! -d ./data/ ]; then
  # If data directory doesn't exist create it
  mkdir ./data/
fi

wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz --directory-prefix ./data/
tar -xvzf ./data/cifar-10-python.tar.gz --directory ./data/
rm ./data/cifar-10-python.tar.gz
#mv ./data/cifar-10-python ./data/cifar-10

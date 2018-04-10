:'This script downloads the raw "Labeled Faces in the Wild" dataset

Dataset description:
13233 images
5749 people
1680 people with two or more images
250x250 pixel images
'

# Run this script for the root of this repository.
if [ ! -d ./data/ ]; then
  # If data directory doesn't exist create it
  mkdir ./data/
fi

wget http://vis-www.cs.umass.edu/lfw/lfw.tgz --directory-prefix ./data/
tar -xvzf ./data/lfw.tgz --directory ./data/
rm ./data/lfw.tgz
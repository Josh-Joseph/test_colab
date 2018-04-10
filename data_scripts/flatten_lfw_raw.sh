# Move every file in each sub-directory of /lfw/ to /lfw/ and remove the sub-directory.

for D in ./data/lfw/*; do mv $D/* ./data/lfw/; rm -rf $D; done
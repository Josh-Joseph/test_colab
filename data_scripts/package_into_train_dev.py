import os
from pathlib import Path
import shutil
import random
from math import floor


dataset_name = 'faces_vs_all'


label_keys_map = {
    '0_nonface': [
        # '/content/raw_data/private_proof_v1/architecture',
        # '/content/raw_data/private_proof_v1/bag',
        # '/content/raw_data/private_proof_v1/font',
        # '/content/raw_data/private_proof_v1/insect',
        # '/content/raw_data/private_proof_v1/landscape',
        # '/content/raw_data/private_proof_v1/machinery',
        # '/content/raw_data/private_proof_v1/ring',
        '/content/raw_data/cifar-10/airplane',
        '/content/raw_data/cifar-10/automobile',
        '/content/raw_data/cifar-10/bird',
        '/content/raw_data/cifar-10/cat',
        '/content/raw_data/cifar-10/deer',
        '/content/raw_data/cifar-10/dog',
        '/content/raw_data/cifar-10/frog',
        '/content/raw_data/cifar-10/horse',
        '/content/raw_data/cifar-10/ship',
        '/content/raw_data/cifar-10/truck'
    ],
    '1_face': [
        '/content/raw_data/lfw'
    ]
}

valid_file_extensions = ['jpg', 'jpeg', 'png']

split_percentages = {'train': 80, 'dev': 20}

# replace the folders with their individual file paths
label_files_map = {}
for label, folder_paths in label_keys_map.items():
    assert type(folder_paths) is list
    label_files_map[label] = []
    for folder_path in folder_paths:
        files = sorted(Path(folder_path).iterdir())
        files = [f for f in files if f.suffix[1:].lower() in valid_file_extensions]
        label_files_map[label] += files
    assert len(label_files_map[label]) > 0

# split the individual file paths for train, dev, and (optionally) test
split = {'train': {}, 'dev': {}}
if 'test' in split_percentages:
    split['test'] = {}

# preferences for extra images due to rounding go test > dev > train
for label, refs in label_files_map.items():
    # Randomly mix the data for this label
    shuffled_refs = refs.copy()
    random.Random(1234).shuffle(shuffled_refs)

    train_split_index = floor(len(shuffled_refs) * split_percentages['train'] / 100)
    split['train'][label] = shuffled_refs[:train_split_index]
    remaining_refs = shuffled_refs[train_split_index:]

    if 'test' not in split_percentages:
        split['dev'][label] = remaining_refs
    else:
        dev_split_index = floor(len(remaining_refs) *
                                (split_percentages['dev'] / (100 - split_percentages['train'])))
        split['dev'][label] = remaining_refs[:dev_split_index]
        split['test'][label] = remaining_refs[dev_split_index:]

temp_processing_path = Path('/content/tmp')
temp_processing_path.mkdir(exist_ok=True)
temp_processing_path = Path('/content/datasets')
temp_processing_path.mkdir(exist_ok=True)
# copy the images into their final dataset directory
local_dataset_path = Path(temp_processing_path, dataset_name)
if os.path.exists(local_dataset_path.as_posix()):
    shutil.rmtree(local_dataset_path.as_posix())
for s in split.keys():
    for label in split[s].keys():
        s_label_folder = Path(local_dataset_path, s, label)
        s_label_folder.mkdir(parents=True)
        for image_source in split[s][label]:
            image_destination = Path(s_label_folder, Path(image_source).name)
            shutil.copy(image_source.as_posix(), image_destination.as_posix())
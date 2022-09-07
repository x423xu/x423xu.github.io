---
layout: post
title: How to deploy singularity for data processing
time: 2022-05-24 11:20:09
---

# Installation
1. Install on local machine from *[singularity-installation](https://sylabs.io/guides/3.0/user-guide/installation.html)*

# Create an "install.def" file:
- An example file: (docker image downloaded from [here](https://hub.docker.com/r/pytorch/pytorch/tags))
```
    Bootstrap: docker
    From: pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel
    %post
        apt-get update
        apt-get install -y gcc
        apt-get install -y g++
        apt-get install -y libglib2.0-0
        apt-get install -y libsm6
        apt-get install -y libx11-dev
        apt-get install -y git


        pip install yacs
        pip install torchvision==0.10.0
        pip install numpy
        pip install matplotlib
        pip install h5py
        pip install pickle-mixin
        pip install Pillow
        pip install tqdm
        pip install pytorch3d
        pip install regex
        pip install requests
        pip install easydict
        pip install ninja
        pip install cython
        pip install dill
        pip install opencv-python
        pip install pycocotools
        pip install cffi
        pip install scipy
        pip install msgpack
        pip install pyaml
        pip install tensorboardX
        pip install timm
```
# Create sif file in sanding box way
1. sudo singularity build --sandbox ./sif/ install.def # create neccessary files for a sandbox in sif folder
2. sudo singularity shell --writable sif/ # open a shell environment for installing packages
3. using `apt-get xxx` or `pip install xxx` to install your desired packages
4. sudo singularity build xiaoyu.sif ./sif/ # build a sif file from sif folder

# Deploy in remote server
1. upload sif file to the remote server.
2. create python virtual env: `python -m venv ./venv --system-site-packages`
3. execute command: `singularity exec --nv -B /scratch/xiaoyu -B /project/def-zhouwang/xiaoyu /project/def-zhouwang/xiaoyu/xiaoyu.sif /scratch/xiaoyu/venv/bin/python train_mde.py ${arg_arr[$SLURM_ARRAY_TASK_ID]}
`
An example shell file:
    ```
    #!/bin/bash
    #SBATCH --account=rrg-zhouwang
    #SBATCH --time=20:00:00
    #SBATCH --job-name=RaMDE
    #SBATCH --gres=gpu:p100:4
    #SBATCH --cpus-per-task=8
    #SBATCH --array=0-7
    #SBATCH --mem-per-cpu=3000M
    #SBATCH --output=./%A-%a.out
    module load singularity
    source /scratch/xiaoyu/venv/bin/activate
    cd /scratch/xiaoyu/depth-estimation/source/RaMDE/

    arg_arr[0]="--bs 8 --workers 4 --data_path ../../data/kitti_data --filenames_file ./train_test_inputs/kitti_eigen_train_files_with_gt.txt --data_path_eval ../../data/kitti_data --filenames_file_eval ./train_test_inputs/kitti_eigen_test_files_with_gt.txt --gt_path ../../data/kitti_depth/ --gt_path_eval ../../data/kitti_depth/ --dataset kitti --do_kb_crop --max_depth 80 --max_eval_num 50 --algo tri_graph --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[1]="--bs 8 --workers 4 --data_path ../../data/kitti_data --filenames_file ./train_test_inputs/kitti_eigen_train_files_with_gt.txt --data_path_eval ../../data/kitti_data --filenames_file_eval ./train_test_inputs/kitti_eigen_test_files_with_gt.txt --gt_path ../../data/kitti_depth/ --gt_path_eval ../../data/kitti_depth/ --dataset kitti --do_kb_crop --max_depth 80 --max_eval_num 50 --algo tri_graph --orthogonal_disable --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[2]="--bs 8 --workers 4 --data_path ../../data/kitti_data --filenames_file ./train_test_inputs/kitti_eigen_train_files_with_gt.txt --data_path_eval ../../data/kitti_data --filenames_file_eval ./train_test_inputs/kitti_eigen_test_files_with_gt.txt --gt_path ../../data/kitti_depth/ --gt_path_eval ../../data/kitti_depth/ --dataset kitti --do_kb_crop --max_depth 80 --max_eval_num 50 --algo tri_graph --attention_disable --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[3]="--bs 8 --workers 4 --data_path ../../data/kitti_data --filenames_file ./train_test_inputs/kitti_eigen_train_files_with_gt.txt --data_path_eval ../../data/kitti_data --filenames_file_eval ./train_test_inputs/kitti_eigen_test_files_with_gt.txt --gt_path ../../data/kitti_depth/ --gt_path_eval ../../data/kitti_depth/ --dataset kitti --do_kb_crop --max_depth 80 --max_eval_num 50 --algo tri_graph --attention_disable --orthogonal_disable --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[4]="--bs 12 --workers 4 --data_path ../../data/NYUv2Whole/nyudepthv2/train --data_path_eval ../../data/NYUv2Whole/nyudepthv2/val --dataset nyu --max_depth 10 --max_eval_num 50 --algo tri_graph --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[5]="--bs 12 --workers 4 --data_path ../../data/NYUv2Whole/nyudepthv2/train --data_path_eval ../../data/NYUv2Whole/nyudepthv2/val --dataset nyu --max_depth 10 --max_eval_num 50 --algo tri_graph --orthogonal_disable --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[6]="--bs 12 --workers 4 --data_path ../../data/NYUv2Whole/nyudepthv2/train --data_path_eval ../../data/NYUv2Whole/nyudepthv2/val --dataset nyu --max_depth 10 --max_eval_num 50 --algo tri_graph --attention_disable --model_name RaMDE --print_every 100 --validate_every 100"
    arg_arr[7]="--bs 12 --workers 4 --data_path ../../data/NYUv2Whole/nyudepthv2/train --data_path_eval ../../data/NYUv2Whole/nyudepthv2/val --dataset nyu --max_depth 10 --max_eval_num 50 --algo tri_graph --attention_disable --orthogonal_disable --model_name RaMDE --print_every 100 --validate_every 100"

    singularity exec --nv -B /scratch/xiaoyu -B /project/def-zhouwang/xiaoyu /project/def-zhouwang/xiaoyu/xiaoyu.sif /scratch/xiaoyu/venv/bin/python train_mde.py ${arg_arr[$SLURM_ARRAY_TASK_ID]}
    ```

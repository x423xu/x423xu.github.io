---
layout: post
title: linux-operations
date: 2022-05-26 17:31:22
---
# Mout a disk
1. using gparted to format the disk to `ext4` file system: `sudo apt-get install gparted` -> `sudo gparted` -> format the disk
2. mount the disk to mountpoint, eg: `sudo mount /dev/sda2 ~/HDD`
3. Permanently mounting: `cat /etc/fstab` to get UUID -> [here](https://devconnected.com/how-to-mount-and-unmount-drives-on-linux/)
4. change the ownership of the folder ~/HDD: sudo chown xxy ~/

# collections
```
    后台运行：nohup python f.py >log 2>&1 &
    解压： tar -xvf
    compress: tar -czvf x.tar.gz path
    查看当前文件夹大小： du -sh
    查看当前文件夹下每个文件的大小：ls ./ -lht
    查看cuda版本：nvcc --version
    linux查看进程详细信息：ll /proc/PID
    传输命令: rsync -avz --no-p --no-g xiaoyu.sif xiaoyu@graham.computecanada.ca:/project/def-zhouwang/xiaoyu/ --progress
    查看cuda路径: python -c "import torch;from torch.utils.cpp_extension import CUDA_HOME;print(CUDA_HOME);print(torch.cuda.is_available())"
    统计当前目录下文件的个数（不包括目录）： ls -l | grep "^-" | wc -l
    统计当前目录下文件的个数（包括子目录）： ls -lR| grep "^-" | wc -l
    查看某目录下文件夹(目录)的个数（包括子目录）： ls -lR | grep "^d" | wc -l
    
    set git using *ssh* rather than *https*: git remote set-url origin git@github.com:x423xu/x423xu.github.io
    复制ssh key: ssh-copy-id -i id_rsa.pub zduanmu@129.97.68.248
    按规则同步: rsync -av --include="*.jpg" --exclude=* ./ xiaoyu@graham.computecanada.ca:/scratch/xiaoyu/depth-estimation/source/RaMDE/test_imgs/ --progress

    open html in remote server:
    1. remote server: python -m http.server 8000
    2. local machine: ssh -L 8000:localhost:8000 server-name
    3. open firefox: http://localhost:8000/file.html

    open a new tab in terminal: ctrl shift t
    set warning error: python -W error

    github tricks:
    create branch: git checkout --orphan branch-name

    vim tricks:


    vnc tricks:
    server:
        ssh graham
        vncserver -MaxConnectionTime 3600 -AlwaysShared	
        grep port /home/xiaoyu/.vnc/gra-login1:3.log
        
        vncserver -list
        vncserver -kill :44
    local:
        ssh graham -L 5901:gra-login1:5903
        vncviewer localhost:5901


    singularity 命令:
    1. build sif file:
    sudo singularity build xiaoyu.sif install.def
    2. using singularity:
    singularity shell --nv -B /scratch/xiaoyu -B /project/6002585/xiaoyu -B /project/6002585/xiaoyu/depth-estimation/source /project/6002585/xiaoyu/xiaoyu.sif
    singularity shell --nv -B /scratch/xiaoyu -B /project/def-zhouwang/xiaoyu /project/def-zhouwang/xiaoyu/xiaoyu.sif
    singularity shell --nv -B /scratch/xiaoyu -B /project/def-zhouwang/xiaoyu /scratch/xiaoyu/xiaoyu.sif
    3. CC交互模式:  salloc --time=3:0:0 --nodes=1 --gres=gpu:4 --cpus-per-task=8 --mem-per-cpu=3000M --account=rrg-zhouwang
    4. CC singularity使用: 1.打开交互模式；2. module load singularity; 3. singularity加载sif文件。或者: 1. module load singularity; 2. sbatch挂载任务

    (apt install -y python3-opencv)
    singularity sandbox build:
    1. sudo singularity build --sandbox ./sif/ install.def
    2.sudo singularity shell --writable sif/
    3.sudo singularity build xiaoyu.sif ./sif/

    CC setup.py:
    1. python -m venv ./venv --system-site-packages
    2. source /project/6002585/xiaoyu/venv/bin/activate
    3. cd ~rcnn
    4. python setup.py build develop

    singularity脚本:
    #!/bin/bash
    #SBATCH --account=rrg-zhouwang
    #SBATCH --time=00:40:00
    #SBATCH --job-name=bls2017_49
    #SBATCH --gres=gpu:1
    #SBATCH --cpus-per-task=8
    #SBATCH --mem-per-cpu=3000M
    #SBATCH --output=/home/z777li/scratch/output/%x-%j.out
    module load singularity
    singularity exec --nv -B /home -B /scratch ~/Documents/tfcompression.sif \
    python ~/Documents/compression/models/bls2017.py --model_path ~/scratch/compression_models/bls2017_49 -V \
    rdcurve --npy_path ~/scratch/bls2017_stats/rdstats_49.npy --split train

    github cheatsheet:
    1.token: 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

    git push:
        git init
        git add README.md
        git commit -m "first commit"
        git branch -M main
        git remote add origin https://github.com/x423xu/x423xu.github.io.git
        git push -u origin main

    make a new jekyll static site:
        step 1: jekyll new xxx #make a new directory
        step 2: cd xxx
        step 3: bundle exec jekyll serve #make it available on a local server
        step 4: push to github
        
    git set remote url:
        git remote set-url origin xxx
        
    !ERROR: Updates were rejected because the remote contains work that you do not have locally. This is usually caused by another repository pushing to the same ref. You may want to first integrate the remote changes (e.g., 'git pull ...') before pushing again.
        git push -f origin main
        #comment: this error is caused by the difference of local branch and remote branch. with '-f' arg, the local branch will be forced to update to the remote.

    configure github login with access token:
        gh auth login
        
    delete remote branch or local branch:
        git push origin --delete main #delete
        git branch -D main	       #local

    create local branch:
        git branch main
        
    switch to a different branch:
        git checkout xxx
        
    add all files to branch:
        git add -f .

    uncommit 1 committing: git reset HEAD~1
    
    tmux常用命令:
    1.创建session: tmux new -s xxy
    2.列出现有session: tmux ls
    3.删除session: tmux kill-session -t xxy
    4.进入session: tmux a -t xxy
    5.退出session: tmux detach
    //创建window：Ctrl+b +c
    //删除window：Ctrl+b &
    //下一个window：Ctrl+b n
    //上一个window：Ctrl+b p
    //重命名window：Ctrl+b ,
    //在多个window里搜索关键字：Ctrl+b f
    //在相邻的两个window里切换：Ctrl+b l
    //横切split pane horizontal：Ctrl+b ” (问号的上面，shift+’)
    //竖切split pane vertical：Ctrl+b % （shift+5）
    //按顺序在pane之间移动：Ctrl+b o
    //上下左右选择pane：Ctrl+b 方向键上下左右
    //调整pane的大小：Ctrl+b :resize-pane -U #向上
    Ctrl+b :resize-pane -D #向下
    Ctrl+b :resize-pane -L #向左
    Ctrl+b :resize-pane -R #向右
    在上下左右的调整里，最后的参数可以加数字 用以控制移动的大小，例如：
    Ctrl+b :resize-pane -D 50
    //在同一个window里左右移动pane：Ctrl+b { （往左边，往上面）：Ctrl+b } （往右边，往下面）
    //删除pane：Ctrl+b x
    //更换pane排版：Ctrl+b “空格”
    //移动pane至window：Ctrl+b !
    //移动pane合并至某个window：Ctrl+b :join-pane -t $window_name
    //显示pane编号：Ctrl+b q
    //按顺序移动pane位置：Ctrl+b Ctrl+o

    python train_mde.py --bs 4 --workers 2 --data_path ../../data/kitti_data --filenames_file ./train_test_inputs/kitti_eigen_train_files_with_gt.txt --data_path_eval ../../data/kitti_data --filenames_file_eval ./train_test_inputs/kitti_eigen_test_files_with_gt.txt --gt_path ../../data/kitti_depth/ --gt_path_eval ../../data/kitti_depth/ --dataset kitti --do_kb_crop --max_depth 80 --max_eval_num 50 --algo tri_graph

    python train_mde.py --bs 16 --workers 4 --data_path ../../data/NYUv2Whole/nyudepthv2/train --data_path_eval ../../data/NYUv2Whole/nyudepthv2/val --dataset nyu --max_depth 10 --max_eval_num 50 --algo tri_graph --validate_every 1 --print_every 1
```
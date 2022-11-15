---
title: "Jupyterhub"
date: 2022-11-07T12:59:14-05:00
layout: post
tags: ["tools"]
---

Here I would introduce how to use jupyter hub in HPC

# Introduction 

JupyterHub is the best way to serve Jupyter notebook for multiple users. Because jupyterhub manages a separate Jupyter encironment for each user, it can be used in a class of students, a corporate data scientific research group. It is a multi-user Hub that spawns, manages, and proxies multiple instances of the sinfle0user Jupyter notebook server.

It offers distributions for different use cases.
1. **The little JupyterHub** for numbre of users (1-100)
2. **Zero to JupyterHub with Kubernets** deploy dynamic servers on the cloud for more users.

Four subsystems:
- a **Hub** is the heart
- a**configurable HTTP Procy** receives the requests from the client's browser
- multiple **Single-User Jupyter Notebook Servers** monitores by Spawners.
- an **Authentication Class** manages how users can access the system.

![jupyterhub](/assets/images/jupyterhub.png)

Functions:
- The Hub launches a proxy
- The proxy forwards all requests to the Hub by default
- The Hub handles user login and spawns single-user servers on demand
- The Hub configures the procy to forward URL prefixes to the single-user notebook servers.

By default, a notebook server runs locally at 127.0.0.1:8888 and is accessible only from localhost. You may access the notebook server from the browser using http://127.0.0.1:8888.

# HowTo

```
Steps:
    first login:
        0. cd scratch
        1. module load python
        2. virtualenv --no-download jupyter_py3
        3. source jupyter_py3/bin/activate
        4. pip install --no-index --upgrade pip
        5. pip install --no-index jupyterlab
        6. echo -e '#!/bin/bash\nunset XDG_RUNTIME_DIR\njupyter lab --ip $(hostname -f) --no-browser' > $VIRTUAL_ENV/bin/jupyterlab.sh
        7. chmod u+x $VIRTUAL_ENV/bin/jupyterlab.sh
    next login:
        source jupyter_py3/bin/activate
        salloc --time=3:0:0 --nodes=1 --gres=gpu:1 --ntasks=1 --cpus-per-task=8 --mem-per-cpu=3000M --account=def-zhouwang --x11 srun $VIRTUAL_ENV/bin/jupyterlab.sh
    local:
        sshuttle --dns -Nr xiaoyu@beluga.computecanada.ca
    
```
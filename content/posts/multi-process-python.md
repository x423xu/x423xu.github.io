---
title: "Multiple Processing in Python"
date: 2023-01-13T13:19:11-05:00
layout: post
tags: ["tools"]
draft: true
---

# Goals

I am recently working on a computer vision task and need a large volume data to be downloaded and processed. However, it takes too much time working in a single thread. So, working in parrallel way in a HPC system would be a better choice.

1. Understand the multiprocessing, subprocess, threading package in python
2. The workflow for a MPI work
3. Transfer to HPC

# Multiprocessing package: Process-based parallelism
1. `Pool` object: parallelizing execution and distributing data (data parallelism)

Basic example:
```
with Pool(processes=5) as p:
    print(p.map(f, [1, 2, 3]))
```

2. `Process` class: processes are spawned by creating a `Process` object and then calling its `start()` method.

Basic example:
```
p = Process(target=f, args=('bob',))
p.start()
p.join()
```

`join()` method blocks the execution of the main process until the process whose join method is called terminates. Without it, the main process won't wait.


# Difference between subprocess and multiprocess

- `subprocess` helps the python code spawn a new process to execute external source code like `c++`, `shell`

- `multiprocess` spawns multiple processes for data processing or other parallel works.

# Difference between Pool and Process
In my setting:
- `Pool` for multiple threads
- `Process` for multiple processes

# Deploy on HPC
Note to specify `cpus-per-task` $\geq$ `Processes` $\times$ `Pools`.
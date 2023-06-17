---
title: "Debugs"
date: 2022-11-06T17:08:52-05:00
layout: post
tags: ["debug"]
---

1. 
```
X Error of failed request:  GLXBadContext
Major opcode of failed request:  152 (GLX)
Minor opcode of failed request:  6 (X_GLXIsDirect)
Serial number of failed request:  39
Current serial number in output stream:  38
```

- Reproduce: on compute canada, with singularity, installed `mesa-utils`, `libgl1-mesa-glx`. 
```
python
from vedo import Plotter
v = Plotter()
v.show()
```

- Solution: use `--nv` args in `singularity shell` command.

- Experience: the mesa requires nvidia graphical card to run correctly. It is necessary to have one GPU.

2. 
```
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
```

- Solution: `export LIBGL_ALWAYS_INDIRECT=1`, `apt-get install -y mesa-utils libgl1-mesa-glx`

3. in pytorch lightning when I use DDP for training, the code collapsed when validation loop finishes and models are checkpointed. That is caused by the valiadation batch size across each process is not same. In my case, 465 val batches in total, each process has 117 val batches

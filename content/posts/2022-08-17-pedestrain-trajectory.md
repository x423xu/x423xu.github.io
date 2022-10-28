---
layout: post
title: pedestrain-trajectory
date: 2022-08-17 13:30:03
tags: ["paper-reading"]
---

# Pedestrain trajectory

Questions:
    1. only pedestrain relation considered? hoe about environment
    2. what is the general framework for pedestrain trajectory prediction.

# SGCN: Sparse Graph Convolution Network for Pedestrain Trajectory Prediction (CVPR2021)
## SGCN framework
![SGCN framework](/assets/images/SGCN-framework.png)

- superfulous interactions:
    1. dense interaction -> one pedestrain is related to all other pedestrains while in fact it is not
    2. sparse undirected -> equal interactions for a pair of pedestrains
- spatial GCN -> sparse directed -> not all pedestrains + not equal interaction
- temporal GCN -> motion tendency

# Disentangled Multi-Relational Graph Convolutional Network for Pedestrian Trajectory Prediction (AAAI2021)
- Use CNN to generalize complex interpersonal relations
- a graph representation: node as pedestrian, edges correspond to distance

## challeges
- only simple social relationship like collision avoidance is aggregated
- modelling social norms is not suitable for determining the end-points of pedestrians in the last frame (over-avoidance) 
## contributions
- disentangled multi-scale aggregation to clearly distinguish between relevant pedestrians
- multi-relational GCN to extract sophisticated social interaction in a scene.
- a global temporal aggregation to compensate accumulated errors from over-avoidance.

# Gaze target estimation

# Dual Attention Guided Gaze Target Detection in the Wild

- challenges:
    1. prior works: gaze direction in 2D representations + barely depth-channel gaze. forward, backward, sideward. (refer to one person)
    2. salient objects from 2d cues. two candidates different depth along same gaze direction, hard to tell apart. (refer to one person with the scene understanding)
    3. fixation inconsistency: facing forward looking downward.
- solutions:
    1. estimate 3D gaze direction from head image.
    2. dual attention module -> depth-aware perspective in the scene
    3. ?hasn't found effective solution in the paper? -> solved in the first stage? so is it still an independent challenge? or should be merged to the first challenge?

# ESCNet: Gaze Target Detection with the Understanding of 3D Scenes

- hard to handle: multiple salient objects lie in the same depth layer and field of view. occlusion plays an important role in gaze estimation , one cannot see through occluders.
- 3D geometry could br reconstructed by absolute depth and camera parameters

FOV-based initial heatmap.

# Multimodal Across Domains Gaze Target Detection
- gaze target detection also referred as gaze-following
- false detections occur when there are multiple object-of-interests at different depths but along with the subject's gaze direction
- 'dual' potentially being error-prone in real-life processing, e.g., when the eyes are not visible or not detectable
- 'ESCNET' auxiliary estimating depth, depend on depth and pseudo labels.
- not require gaze angles as supervision
- only spatial processing, but still detect gaze target
- use depth image

**how different modalities should be jointly learned for performing effective gaze target detection**

- solve domain shift problem
---
title: "Spectral Gnn"
date: 2022-10-27T22:05:32-04:00
layout: post
tags: ["paper-reading"]
---

# Preface
To understand the basics of the graph neural network, it can't circumvent the topic of "Spectral-GNN". Today, I'd like to deeply explore what the spectral GNN is and how does it works.

# Table of contents

[Theory part](#basic-theory)


# Basic theory
```
<The Emerging Field of Signal Processing on Graphs>
```
## challenges
- a "classical" signal $f(t)$ has a concept of "translate to the right by 3" to get $f(t-3)$. But for graph signal, it is not clear to say "translate by 3". Because it doesn't have a clear order, thus is not "shift-invariant".
- Multiplying a signal with a complex exponential signal corresponds to translation in Fourier domain. But the signal on graph is irregulaly spaced, hard to define translation in spectral domain.
- Hard to down sample a signal on graph vertices.
- Need a method to create a coarser graph which somehow captures the structural properties from the original one.
- Need a method, localized operations, to compute information from a small neighboring vertices.

## Problem settings
A weighted graph $G$ is always expressed as $G = \{V, E, W\}$, which contains vertices $V$ with $|V| = N$, a set of edges $E$ and adjacency matrix $W$. If the edge $e(i,j)$ which connect two vertices $i, j$ exists, the entry $w_{i,j}$ denotes the weight of the edge; otherwise $w_{i,j} = 0$. Sometimes the graph $G$ can be separated into several subgraphs, these subgraphs are insides connected while not connected mutually. So the graph would be represented as $M$ pieces connected components. A signal or function defined on the vertices are denoted as $\{f:V\rightarrow \real, f\in \real^N\}$. In a graph neural network, the $f$ generally represented embedded features with $f\in\real^{S\times N}$, where $S$ denotes the shape of features.

## The Graph Laplacian
Here the graph laplacian refers to the unormalized one. Generally in a graph, the laplacian is defined as $L = D-W$. $D$ is a degree matrix, which is diagonal with $i$-th diagonal entry $D_i = \sum_j w_{i,j}$. Given the defined signal $f$ on the graph, the laplacian operation of the $f$ is formulated as:
$$(Lf)(i) = \sum_{i\in N_i}w_{i,j}[f(i)-f(j)]$$
The laplacian operator in actually a difference operator, which describe the average difference level between the vertice $i$ and its neighboring vertices $N_i$.

There are some definitions and properties for laplacian matrix to be explained in advance for better comprehension
1. The laplacian matrix is a real symmetric matrix, it has a complete set of orthonormal eigenvectors, denoted as $\{u_l\}$, and corresponding real nonpositive eigenvalues $\{\lambda_l\}_{l= 0,1,\cdots,N-1}$
2. The number of zero eigenvalues indicates the number of connected componnets, namely subgraphs.
3. The eigenvalues of laplacian matrix is sorted as $0=\lambda_0<\lambda_1\leq\lambda_2\cdots\leq\lambda_{N-1}=\lambda_{max}$. The spectrum of the laplacian matrix is defined as $\{\lambda_0, \lambda_1,\cdots,\lambda_{N-1}\}$

## A graph transform
Recall the classical Fourier transform on one-dimensional continuous signal
$$\hat{f}(\xi) = <f, e^{2\pi j\xi t}>=\int_{\real}f(t)e^{-2\pi j\xi t}dt$$
The Fourier transform can be understood as the expansion of the signal $f(t)$ with the complex exponentials $e^{2\pi j\xi t}$. What is interesting is the complex exponential $e^{2\pi j \xi t}$ is an eigenfunction of laplace operator
$$-\Delta(e^{2\pi j \xi t}) = -\frac{\partial^2}{\partial t^2}e^{2\pi j \xi t} =K\cdot e^{2\pi j \xi t}$$
One step further, the $e^{2\pi j \xi t}$ is the eigenfunction for any order derivation operators. The Fourier transform can be understood as to project a signal from temporal domain to spectral domain. According to the same way, the graph transform is defined as
$$\hat{f}(\lambda_l) = <f, u_l>=\sum_i f(i)u^*_i$$
The connections between the graph transform and Fourier transform can be explained in this way: for Fourier transform, it has a space which is constructed on bases $e^{2\pi j \xi t}$. Each signal $f(t)$ can be represented by these bases, the coefficient of which is exactly the $\hat{f}(\xi)$. The bases can be seen as the eigenvectors for Fourier transform, and the eigenvalue is ${f}(\xi)$ (this is just a kind of analogy, since the Fourier trasform is operated on continuous signal). For graph transform, each graph signal $f$ is transformed into the spectral domain, which has bases $\{u_1, u_2,\cdots u_i \}$. So the eigenvectors $u_l$ corresponding to low frequency $\lambda_l$ vary slowly across the graph and vice versa.

## Spectral graph convolution
Given the node features $X$ and convolutional kernel $H$, the process of the spectral-based GNN is formulated in the following steps:

1. Eigen-decomposition of Laplacian matrix $L$: $L = U \Lambda U^{\top}$. Each column of the $U$ is the eigenvector of the $L$. $\Lambda$ is a diagonal matrix composed of eigenvalues. Now the Laplacian matrix of a graph $G$ is decomposed into a set of orthogonal bases. The input node features $X$ can be projected to the space formed with the bases.

2. Project the $G$ and $X$ to the spectral domain using $U$: 
$$
    \begin{split}
    \hat{H} &= U^{\top}\cdot H \\
    \hat{X} &= U^{\top}\cdot X
    \end{split}
$$

3. Spectral multiplication and reprojection: 
$$
    \begin{split}
    X^{\prime} &= U(\hat{H}\cdot \hat{X}) \\
               &= U(U^{\top}\cdot H \cdot U^{\top}\cdot X)
    \end{split}
$$

The $X^{\prime}$ denotes the output feature of one GNN layer. To get deep GNN, multiple layers need to be stacked and rerun the above steps. 
For the final output node features, there are two kinds of tasks that can be applied. One is the node-level task, such as social media accounts classification, in which each social media account is represented as one node. The second is the graph-level task, such as text classification, in which each word in the text is seen as one node and the whole graph can be classified as spam or not.

# Methods

# Demos to evaluate the properties
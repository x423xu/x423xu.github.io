---
layout: post
title:  "Paper summary" 
time:   2022-04-06 11:58:35 -0400
---

# 2022/3/31 ~ 2022/4/6
## Order-Embeddings of images and Language
### Core idea
- Explicitly modeling the partial order structure of the hierarchy over language and image -> **Visual sematic hierarchy**

### How to do it
- Penalize order violations
$$ E(x,y) = ||max(0,y-x)||^2 $$
where $E(x,y)=0 \Leftrightarrow x \preceq y$

## Modeling heterogeneous hierarchies with relation-specific hyperbolic cones
### Core idea
- Embeds entities into hyperbolic cones & models relations as transformations between the cones

### How to do it
- Poincare entailment cone at apex $x$ $$\zeta_x = \{y\in \Beta^d | \angle_xy\leq\sin^{-1}(K\frac{1-||x||^2}{||x||})\}$$
- embed entity: $h=(h_1,h_2,\cdots,h_{d})$, where $h_i\in\Beta^2$ is the apex of the $i-$th 2D hyperbolic cone.
- Transformation:
  1. Rotation transformation: $f_1(h,r) = \exp_o(\mathbf{G}(\theta)\log_o(h))$, where $\mathbf{G(\theta)=\left[\begin{matrix}cos(\theta)&-sin(\theta)\\sin(\theta)&cos(\theta)\end{matrix}\right]}$
  2. Restricted rotation transformation:$f_2(h,r)=\exp_h(s\cdot \mathbf{G}(\theta\frac{\phi}{\pi})\bar h), r=(s,\theta)$
- Loss function:
  1. $\ell_d=-\log\sigma(\psi(h,r,t))-\sum_{t^{'}}\frac{1}{|T|}\log\sigma(-\psi(h,r,t^{'}))$
  2. $\ell_a(h,r,t)=m\cdot(max(0,\angle_{h_i}t_i-\phi(h_i)))$

## Learning to detect unseen object classes by between-class attribute transfer
### Core idea
- Decompose an image/object into high-level semantic attributes such as shape, color, geographic information. Then detect new classes based on their attribute representations.

### How to do it
- Direct attribute prediction:
  1. decouple training images into attribute variables $\alpha_m$
  2. per-attribute parameters $\beta_m$ 
  3. at test: image $x\rightarrow\beta_m\rightarrow \alpha_m\rightarrow class$
   $$p(z|x)=\sum_{a\in\{0,1\}^M}p(z|a)p(a|x) = \frac{p(z)}{p(a^z)}\prod_{m=1}^{M}p(a_m^z|x)$$
- Indirect attribute prediction
  1. add an attribute layer between two label layers
  2. for the indirect one, $p(a_m|x)=\sum_{k=1}^K p(a_m|y_k)p(y_k|x)$

## Zero-shot learning via joint similarity embedding

### Core idea
- To test if source-target pair matches each other

## Multi-grained vision language pre-training: aligning texts with visual concepts
### Core idea
- Locate visual concepts in the image given the associated texts & align the texts with the visual concepts.

### How to do it
- Bounding box loss:
$$\ell_{bbox} = \mathbb{E}_{(V^j,T^j)\sim I;I\sim D}\left[\ell_{iou}(b_j,\hat{b}_j)+||b_j-\hat{b}_j||_1\right]$$
- Contrastive learning:
  $$p^{v2t}(V) = \frac{\exp(s(V,t)/\tau)}{\sum_{i=1}^{N}\exp(s(V,T^i)/\tau)}$$
  $$p^{t2v}(T) = \frac{\exp(s(V,t)/\tau)}{\sum_{i=1}^{N}\exp(s(V^i,T)/\tau)}$$
  $$\ell_{cl}=\frac{1}{2}\mathbb{E}_{V,T\sim D}\left[H(y^{v2t}(V),p^{v2t}(V))+H(y^{t2v}(T),p^{t2v}(T))\right]$$
- Match prediction: whether a pair of visual concept and text is matched.
  $$\ell_{match} = \mathbb{E}_{V,T\sim D}H(y^{match},p^{match}(V,T))$$
- Masked Language Modeling: predict the masked words in the text based on the visual concept
  $$\ell_{mlm} = \mathbb{E}_{t_j\sim \hat{T};(V,\hat{T}\sim D)}H(y^j, p^j(V,\hat{T}))$$

---

# Visual Turing test for computer vision system
## Abstract
- An operator-assisted device that produces a stochastic sequence of binary questions from a given test image. The query engine proposes a question, the operator either provides correct answer or rejects the question as ambiguous. 
- The system is designed to produce streams of questions that follw natural storylines, from the instantiation of a unique object, through an exploration of its properties, and on to its relationships with other uniquely instantiated objects.

## Introduction
- Alan Turing proposed that the ultimate test of a machine could think ot think at least as well as a person was for a human judge to be unable to tell which was which based on natural language conversations in an appropriately cloaked scenario. Or how well a computer can imitate a human.
- Semantic image interpretation-image to words

**Research shows that human brain can only think about one idea at a time**

---

# Visual grounding overview
## TransVG: End-to-End Visual Grounding with Transformers
<img src="/assets/images/TransVG.png" width=600>

### Introduction
- Two-stage methods measure the similarity between region and expression embedding with an MLP.
- One-stage methods encode the language vector to visual feature by direct concatenation.
- Challenges: 
  1. lead to sub-optimal results on long and complex language expressions. 
  2. Built on pre-defined structures of language queries or image scenes. 
  3. Ground object in an indirect way: candidates are sparse region proposals, or dense anchors. So the performance would be influenced by the proposals.
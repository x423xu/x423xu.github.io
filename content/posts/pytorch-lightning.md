---
title: "Pytorch Lightning"
date: 2022-10-31T16:43:31-04:00
# draft: true
layout: post
tags: ["tools"]
---

# what is pytorch lightning

PyTorch Lightning is the deep learning framework with “batteries included” for professional AI researchers and machine learning engineers who need maximal flexibility while super-charging performance at scale.

**quick start**

{{< rawhtml >}}
<video width=100% controls autoplay>
    <source src="https://pl-bolts-doc-images.s3.us-east-2.amazonaws.com/pl_docs/pl_docs_animation_final.m4v" type="video/webm">
    Your browser does not support the video tag.  
</video>
{{< /rawhtml >}}

## summary
steps:
1. lightning module
2. forward func
3. configure optimizers
4. def training_step
5. def validation_step
6. remove .cuda()
7. backward and step as hook
8. init lightning module
9. init trainer
10. add other functions as call back

# explanation about dataloader and sampler
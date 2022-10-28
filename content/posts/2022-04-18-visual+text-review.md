---
layout: post
title: visual text review
date: 2022-04-18 10:52:07
---
# Trends in Integration of Vision and Language Research: A Survey of Tasks, Datasets, and Methods
## Abstract
> Focus on ten prominent tasks that integrate language and vision by discussing their problem formulation, methods, existing datasets, evaluation measures, and compare results with the SOTA methods.

## Introduction
- Multimodal learning models:
    1. generate comprehensible but concise and grammatically well-formed descriptions of the visual content, or vice versa by generating the visual content for a given textual description in a natural language of choice,
    2. identify objets in the visual content and infer their relationships to reson about, or answer arbitrary questions about them,
    3. navigate through and environment by leveraging input from both vision and natural language instructions,
    4. translate textual content from one language to another while leveraging the visual content for sense disambiguation,
    5. generate stories about the visual content, and so on.
- Applications:
    1. visually impaired individuals can be asisted thereby.
    2. automatic survelliance
    3. autonomous driving
    4. human-computer interaction
    5. city navigation
- Task-specific multimodal models
    1. image description (Bernardi et al.,2016; Bai & An, 2018; Hossain et al., 2019)
    2. video description generation (Aafaq et al.,2020)
    3. visual question answering (Kafle & Kanan, 2017; Wu et al., 2017)
    4. action recognition (Gella & Keller, 2017)
    5. visual semantics (Liu et al., 2019)
    6. NLP natual language generation (Gatt & Krahmer, 2018; Garbacea & Mei, 2020)
    7. NLP commonsense reasoning (Storks et al., 2019)
    8. understanding the limitations of the integration of vision and language research (Kafle et al., 2019)

---
## Background
### Computer vision tasks
#### Image as visual information
- Utilization
    1. the tasks where images are used as input
    2. the representation of images
- Tasks
    1. Image classification
    2. Object localization
    3. Object detection
    4. Object segmentation
    5. Object Identification
    6. Instance segmentation
    7. Panoptic segmentation
- Reoresentation
    >self supervised learning (Jing & Tian, 2019)

#### Video as visual information
- Utilization
    1. knowing the tasks where videos are used as inputs
    2. the representation of a video
- Takss
    1. Object tracking
    2. Action classification
    3. Emotion detection
    4. Scene detection
    5. Automated editing

### NLP tasks
- Tasks
    1. understanding language
    2. generating language
    > Some of the classical NLP tasks, that are used to comprehend language, are shallow parsing, syntax parsing, semantic role labeling, named entity recognition, entity linking, co-reference resolution, etc.
- Representation

### CV and NLP integration tasks
<img src="/assets/images/vl_framework.png" width=600>

#### Extension of NLP tasks
- Visual Description Generation: The goal is to generate a human-readable text snippt that describes the input
- Visual Storytelling: A sequence of visual inputs is used to generate a narrative summary based on text aligned with them
- Visual Question Answering: Answer questions about a visual input.
- Visual Dialog: Aim at creating a meaningful dislog in a natural and conversational language about a visual content.
- Visual Reeferring Expression:
- Visual Entailment: An inference task for predicting whether the image semantically entails the text.
- Multimodal Machine Traslation: Translate from source language to target language by leveraging the visual information as auxiliary modality along with the natural language text in source language.

#### Extension of CV tasks
- Visual generation: generate visual content by conditioning on input text from a chosen natural language.
- Visual resoning: It is expected to output a relationship between detected objects by generating an entire visual scene graph. The scene graph is leverage to reason and answer questions about visual content. It can also be used to reason about whether a natural language statement is true or not regarding a visual input.

#### Extension of both NLP and CV tasks
- Vision-and-Language Navigation: natural language navigation should be interpreted based on visual input. Combine both vision and language.

---
## Visual Description Generation and Storytelling
> generate a textual description when conditioned on visual input

### Visual description generation
> Aim to generate either a global descriptionor dense captions for a given visual input.
#### Image description generation
- Standard image description generation: generate a sentence-level description of the scene in a given image
- Dense image description generation: create descriptions at the local object-level in a given image.
- Image paragraph generation: create paragraphs instead of generating a single simple description. Generated paragraphs are expected to be coherent and contain fine-grained natural language descriptions.
- Spoken language image description generation: expand the description generation task to work with spoken language, instead o flimiting to only the written forms of language.
- Stylistic image description generation: add style to the standard image description generation, where the generated descriptions adhere to a specific style.
- Unseen objects image description generation: leverage images which lack paired descriptions. Generate descriptions for visual object categories previously unseen in image-description corpora.
- Diverse image description generation: incorporate variety and diversity in the generated captions.
- Controllable image description generation: select specific objects in an image, defined by a control signal, to generate descriptions.
- Image caption emendation as generation: build a model to emend both syntactic and semantic errors in the captions. 
#### Video description generation
- Global description generation: 
    1. ground sentences that describe actions in the visual information extracted from videos (Motwani & Mooney, 2012; Regneri et al., 2013)
    2. Generate global natural language descriptions for videos with various approaches: _leveraging latent topics_ (Das et al., 2013), _corpora knowledge_ (Krishnamoorthy et al., 2013), _graphical models_ (Rohrbach et al., 2013), and _sequence-to-sequence_ learning (Venugopalan et al., 2015b, 2015a; Donahue et al., 2015; Srivastava et al., 2015; Xu et al., 2016; Ramanishka et al., 2016; Jin et al., 2016), _factor graph_(Thomason et al., 2014) combines visual detection with language statistics.
    3. Seq2seeq based approaches: extra corpora (Venugopalan et al., 2016), soft-attention (Yao et al., 2015), multimodal fusion (Hori et al., 2017), temporal attention (Song et al., 2017), semantic consistency (Gao et al., 2017), residual connections(Li et al., 2019). Incorporation of semantic attributes learned from videos, ensembled-based description generator networks (Shetty et al., 2018), encoder-decoder reconstructors (Wang et al., 2018).
    4. Other approaches: combined with entailment generation task (Pasunuru & Bansal, 2017a), multiple fine-grained actions (Wang et al., 2018b), reinforcement learning (Pasunuru & Bansal, 2017b), Visual Text correction system (Mazaheri & Shah, 2018), object relational graph baed encoder, language model decoder (Zhang et al., 2020).

- Dense video description generation: 
    >achieve fine-grained video understanding by addressing two sub-problems: (1) localizing events in a video, and (2) generating captions for these localized events. the core challenge, namely the automatic evaluation of video captioning, is still unsolved.
- Movie description generation: input movie clips, align books to movies (Tapaswi et al., 2015; Zhu et al., 2015), movie descriptions (Rohrbach et al., 2015).

### Visual storytelling
> The task of visual storytelling aims to encode a sequence of images or frames (in the video) to generate a paragraph which is story-like.
#### Image storytelling
> The aim of image storytelling is to generate stories from a sequence of images.
- semantic coherence is captured in a photo stream.
- discover semantic embeddings correlations (Yu et al., 2017), incorporated with reinforcement learning (Wang et al., 2018), hierarchically structured reinforced training (Huang et al., 2019), adversarial reward learning Wang et al. (2018a).
- suffer from _repetitiveness_, the same objects/events undermine a good story structure. -> inter-sentence diversity was explored with diverse beam search (Hsu et al., 2018).
#### Video storytelling (less explored)
>In comparison to image storytelling, which only deals with a small sequence of images, the aim of video storytelling is to generate coherent and succinct stories for long videos.
- Pinoeer Li et al. (2020) address challenges like diversity in the story and the inherent complexity of video.
- goal: offer support to people with visual disabilities or technical issues like internet bandwidth limitations.

---
## Visual Referring Expression Comprehension and Generation
> The objective of the task is to ground a natural language expression (e.g. a noun phrase or a longer piece of text) to objects in a visual input.
### Image referring expression comprehension and generation
>In a natural environment, people use referring expressions to unambiguously identify, indicate, or point to particular objects. This is usually done with a simple phrase or within a larger context (e.g. a sentence). Having  a larger context provides better scope for avoiding ambiguity and allows the referential expression to easily map to the target object. However, there can also be other possibilities in which people are asked to describe a target object based on its surrounding objects.
- used to generate, an algorithm generates a referring expression for a given target object which is present in a visual scene
    - approaches: (FitzGerald et al., 2013) tackled the problem from the perspective of density estimation, learn distributions over logical exprssions identifying sets of objects in the world.
- used to perform comprehension, an algorithm locates in an image the object described by a given referring expression.
    - approaches: Nagaraja et al. (2016) integrate contexts between objects. Multiple Instance Learning (MIL). Hu et al. (2016) leverage a NLP query of the object to localize a target object, integrating spatial configurations and global scene-level contextual information. (Yu et al., 2018) subject appearence, location, and relationship to other objects. (Cirik et al., 2018a) syntactic analysis, build a dynamic computation graph. variational model (Zhang et al., 2018)
    - cross-modal: (Yang et al., 2019) cross-modal relationship inference， 1. highlight objects and relationships connected with a referring, 2. multi-modal semantic contexts. (可以将空间的referring用到depth estimation里面吗)。Recursive Grounding Tree (Hong et al., 2019) binary tree to parse referring expression-> visual reasoning. (Liu et al., 2019), combining visual reasoning with referential expressions. object segmentation based referring expression (Liu et al., 2017).

### Image referring expression comprehension and generation combination
- (Mao et al., 2016; Yu et al., 2016) find visual comparison to other objects within an image. **(Yu et al., 2017a)** a speaker, a listener, and a reinforcer. The speaker generate referring expressions, the listner comprehend referring expressions, the reinforce use a reward function to guide sampling of more discriminative expressions.

### Video referring expression comprehension and generation 
- Vasudevan et al. (2018) stereo videos to explore temporal-spatial contextual information. Khoreva et al. (2018) language referring expressions to achieve object segmentation. Wang et al. (2020) video grounding with contextual information.

---
## Visual question answering, reasoning, and entailment
> they share the common intention of answering questions when conditioned on a visual input

### Visual question answering
> The goal of Visual Question Answering (VQA) is to learn a model that comprehends visual content at both the global and local level for finding an association with pairs of questions and answers in the natural language form.
- Image Q&A as Visual Turing Test (Malinowski & Fritz, 2014; Malinowski et al., 2015; Geman et al., 2015). fill-in-the-blank tasks (Yu et al., 2015), multiple-choice question-answering for images. Address open-ended Image Q&A (Antol et al., 2015; Agrawal et al., 2017), ask free-form natural language question. Binary image Q&A (Zhang et al., 2016). Relate local regions in the images (Zhu et al., 2016) by addressing object-level grounding
- Interpretability or explainability by overcoming priors (Agrawal et al., 2018). Generate human-interpretable rules that provide better insights **(Manjunatha et al., 2019)**. cycle-consistency (Shah et al., 2019a). outside knowledge (Marino et al., 2019)(Shah et al., 2019b).
- Multi-task learning, federated learning.

### Video question answering
> is to answer natural language questions about videos.
- (Tu et al., 2014) jointly parsing videos with corresponding text to answer queries. open-ended movie Q&A (Tapaswi et al., 2016). fill-in-the-blank questions (Zhu et al., 2017; Mazaheri et al., 2017). (Zeng et al., 2017) free-form Q&A. High-level concept words (Yu et al., 2017b). Attention (Jang et al., 2017). **spatio-temporal grounding (Lei et al., 2020)**
- STAGE (Lei et al., 2020), aligned fusion is essential for improving Video Q&A.

### Visual reasoning
> is to learn a model that comprehends the visual content by reasoning about it.

#### Image reasoning 
> s to answer sophisticated queries by reasoning about the visual world.
- (Johnson et al., 2017a) design diagnostic tests going beyond benchmarks. VQA struggle with comparing the attributes of objects or novel attribute combinations. (Johnson et al., 2017b) program generator. (Hu et al., 2017) predict instance-specific network layouts. Santoro et al. (2017) relation-aware visual features. (Cao et al., 2018) global context reasoning.
- **Mascharka et al. (2018) proposed a set of visual-reasoning primitives.** Learning-By-Asking (LBA) (Misra et al., 2018b), mimic natural learning with the goal to make it more data efficient. compositional attention networks (Hudson & Manning, 2018) explicit and expressive reasoning.
- **neural-symbolic visual question answering (Yi et al., 2018)**, recover structural scene representation from the image and a program trace from the question. **Neuro-Symbolic Concept Learner (NS-CL) (Mao et al., 2019)** learns visual concepts, word, and semantic parsing of sentences without explicit supervision. It learns by simply looking at images and reading paired questions and answers. multimodal relation network (Cadène et al., 2019) learn end-to-end reasoning over real images. Aditya et al. (2019) used spatial knowledge to aid visual reasoning, knowledge distillation, relational resoning, probabilistic logical languages. Explainable and explicit neurla modules (Shi et al., 2019) scene graph.
- **Andreas et al. (2016a, 2016b)** exploit the compositional linguistic structure of complex questions by forming  neural module networks which query about the abstract shapes observed in an image. Compositional question answering (Hudson & Manning, 2019). Zellers et al. (2019) commonsense knowledge. NLVR (Suhr et al., 2017) and NLVR2 (Suhr et al., 2019) true or false.

#### Video reasoning 
> The goal of COG, Yang et al. (2018), is to address problems related to visual and logical reasoning and memory

### Visual entailment
> is to learn a model that predicts whether the visual content entails the augmented text along with hypothesis.
#### Image entailment
- Vu et al. (2018), a visually grounded version of the textual entailment where an image is augmented with textual premise and hypothesis. Xie et al. (2019) predicts whether the image semantically entails the text, given image-sentence pairs, the premise is defined by an image.
#### Video entailment
> (Liu et al., 2020) to infer whether the natural language hypothesis is entailed or contradicted when given a video clip aligned with the subtitles information

---
## Visual Dialog
> involves a complex interaction between a human and an artificial agent.
### Image Dialog
> is to create AI agents that can hold dialog with humans in a natural language of choice about a visual content (Das et al., 2017a), represented by an image. To be more specific, given an image, a history of dialogs, and a question about the image, the goal of an AI agent is to ground the question in the image, infer the context from the history, and then answer the question accurately
- (de Vries et al., 2017) locate an unkown object in the image by asking a swquence of questions. (Mostafazadeh et al., 2017). hold natural-sounding conversations about a shared image.
- (Lu et al., 2017a) transfer from dialog generation. Seo et al. (2017) attentive memory. (Wu et al., 2018) reinforcement learning and GAN. (Kottur et al., 2018) form explicit and grounded co-reference between nouns and pronouns. (Niu et al., 2019) recursive visual attention. (Zheng et al., 2019) graphical model inference. Guo et al. (2019) builds an image-question-answer synergistic network. (Shekhar et al., 2019) a visually grounded encoder guessing and asking questions.
### Video dialog
> is to leverage scene information containing both audio (which can be transcribed as subtitles) and visual frames to hold a dialog (i.e., an exchange) with humans in a natural language of choice about the multimedia content (Alamri et al., 2019b 2019a).
- multimodal-based video description (Hori et al., 2019).

---
## Multimodal Machine Translation (MMT)
> is to translate natural language sentences that describe visual content (e.g. image) in a source language into a target language by taking the visual content as an additional input to the source language sentences.
### Machine tanslation with image
> is to translate sentences, that describe an image, in a source language into equivalent sentences in a target language.
- single source translation, multisource MMT. 
- multimodal attention (Huang et al., 2016). doubly-attentive decoder incorporated visual features (Calixto et al., 2017). learning to translate, and learning visually grounded representations (Elliott & Kádár, 2017). noisy image captions for MMT (Schamoni et al., 2018).
### Machine translation with video
> (Wang et al., 2019b) is to translate a source language description into the target language equivalent using the video information as additional spatio-temporal context.

---
## Language-to-Vision Generation
> is to generate visual content given their natural language descriptions.
### Language-to-Image Generation
- sentence-level language-to-image generation: generate images cnditioned on the natural language descriptions. (Mansimov et al., 2016) iteratively draw patches on a canvas, attending to the relavant words in the description. (Reed et al., 2016b) visual concepts could be translated from characters to pixels with conditional gan. (Reed et al., 2016a) what content should be drawn in which location for high quality image generation. (Nguyen et al., 2017) conditioned on image classes. (Dash et al., 2017) condition on both sentence and class information. stackGAN (Zhang et al., 2017, 2019). attention-based GAN (Xu et al., 2018)
- (Hong et al., 2018) infer the semantic layout of the image. Johnson et al. (2018) used image-specific scene graphs enabling explicitly reasoning about objects and their relationships.
#### Image manipulation
- TAGAN (Nam et al., 2018) generate semantically manipulated images while preserving text-irrelevant contents. Only regions correspond to the given text are modified. (Zhu et al., 2019) attention generator, discriminator. (Li et al., 2020) designed error correction modules to rectify mismatched attributes and complete the missing contents.
#### Fine-grained image generation
- (El-Nouby et al., 2018) recurrent image generation, output up to the current step & past instructions. (Hinz et al., 2019) control location of objects by adding a pathway in an iterative manner.
#### Sequential image generation
- StoryGAN (Li et al., 2019b) opposite to storytelling.

### Language-to-Video generation
- (Li et al., 2018) conditional generative model

---
## Vision-and-Language Navigation
> is to carry out navigation in an environment by interpreting natural language instructions
### Image-and-Language Navigation
- (Anderson et al., 2018b) an autonomous agent navigate in an environment by interpreting natural language instructions. (Wang et al., 2019a), reinforced cross-modal matching. (Fried et al., 2018) train an action space with an embedded speaker model.
- Embodied Question Answering (Das et al., 2018a, 2018b). interactive question answering (Gordon et al., 2018). grounded dialog (de Vries et al., 2018)

---
## Vison-and-Language pretraining
> To jointly learn representations using both visual and textual content
### Single-stream architectures 
- BERT-like (Devlin et al., 2019). VideoBERT (Sun et al., 2019). Bounding Boxes in Text Transformer (B2T2) (Alberti et al., 2019). Unicoder-VL (Li et al., 2020). VL-BERT (Su et al., 2020), VLP (Zhou et al., 2020), OSCAR (Li et al., 202), VinVL (Zhang et al., 2021) can jointly understand and generate from cross-modal data. (Cao et al., 2020) probe.
### Two-stream architectures
- two independent encoders for learning visual and text representations. ViLBERT (Lu et al., 2019) and LXMERT (Tan & Bansal, 2019).

-neuro-symbolic reasoning systems (Yi et al., 2018; Vedantam et al., 2019).

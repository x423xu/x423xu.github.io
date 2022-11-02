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

`LightningDataModule` was designed as a way of decoupling data-related hooks from the `LightningDataModule`, so you can develop dataset agonostic models. The `LightningDataModule` makes it easy to hot swap different Datasets with your model, so you can test it and benchmark it across domains. It also makes sharing and resuing the exact data splits and transforms across projects possible.

**LIGHTNINGDATAMODULE**
{{< rawhtml >}}
<video width=100% controls autoplay>
    <source src="https://pl-bolts-doc-images.s3.us-east-2.amazonaws.com/pl_docs/pt_dm_vid.m4v" type="video/webm">
    Your browser does not support the video tag.  
</video>
{{< /rawhtml >}}

- A datamodule encapsulates the five steps involved in data preprocessing in Pytorch:
    1. Download/tokenize/process
    2. Clean and save to disk
    3. Load inside Dataset
    4. Apply transforms
    5. Wrap inside a dataloader

- The class can then be shared and used anywhere
```
    from pl_bolts.datamodules import CIFAR10DataModule, ImagenetDataModule

    model = LitClassifier()
    trainer = Trainer()

    imagenet = ImagenetDataModule()
    trainer.fit(model, datamodule=imagenet)

    cifar10 = CIFAR10DataModule()
    trainer.fit(model, datamodule=cifar10)
```

## why do i need a DataModule

In normal pytorch code, the data cleaning or preparation is usually scattered across many files. This makes sharing and reusing the exact splits and transforms across projects impossible. 

The DataModule solves following questions:
- what splists did you use?
- what transforms did you use?
- what normalization did you use?
- how did you prepare/tokenize the data?

## what is a DataModule

A DataModule is simply a collection of a train_dataloader, val_dataloader, test_dataloader and predict_dataloader along with the matching transforms and data precessing/downloads steps required.

- a simply pytorch example:
```
    # regular PyTorch
    test_data = MNIST(my_path, train=False, download=True)
    predict_data = MNIST(my_path, train=False, download=True)
    train_data = MNIST(my_path, train=True, download=True)
    train_data, val_data = random_split(train_data, [55000, 5000])

    train_loader = DataLoader(train_data, batch_size=32)
    val_loader = DataLoader(val_data, batch_size=32)
    test_loader = DataLoader(test_data, batch_size=32)
    predict_loader = DataLoader(predict_data, batch_size=32)

    # Datamodule
    class MNISTDataModule(pl.LightningDataModule):
    def __init__(self, data_dir: str = "path/to/dir", batch_size: int = 32):
        super().__init__()
        self.data_dir = data_dir
        self.batch_size = batch_size

    def setup(self, stage: Optional[str] = None):
        self.mnist_test = MNIST(self.data_dir, train=False)
        self.mnist_predict = MNIST(self.data_dir, train=False)
        mnist_full = MNIST(self.data_dir, train=True)
        self.mnist_train, self.mnist_val = random_split(mnist_full, [55000, 5000])

    def train_dataloader(self):
        return DataLoader(self.mnist_train, batch_size=self.batch_size)

    def val_dataloader(self):
        return DataLoader(self.mnist_val, batch_size=self.batch_size)

    def test_dataloader(self):
        return DataLoader(self.mnist_test, batch_size=self.batch_size)

    def predict_dataloader(self):
        return DataLoader(self.mnist_predict, batch_size=self.batch_size)

    def teardown(self, stage: Optional[str] = None):
        # Used to clean-up when the run is finished
        ...
```

- As the complexity of the preprocessing grows (transforms, multiple-GPU training), you can let lightning handle those details for you while making this dataset reusable so you can share with collegues or use in different projects.
```
    mnist = MNISTDataModule(my_path)
    model = LitClassifier()

    trainer = Trainer()
    trainer.fit(model, mnist)
```
- a more realistic DataModule with reusability
```
    import pytorch_lightning as pl
    from torch.utils.data import random_split, DataLoader

    # Note - you must have torchvision installed for this example
    from torchvision.datasets import MNIST
    from torchvision import transforms


    class MNISTDataModule(pl.LightningDataModule):
        def __init__(self, data_dir: str = "./"):
            super().__init__()
            self.data_dir = data_dir
            self.transform = transforms.Compose([transforms.ToTensor(), transforms.Normalize((0.1307,), (0.3081,))])

        def prepare_data(self):
            # download
            MNIST(self.data_dir, train=True, download=True)
            MNIST(self.data_dir, train=False, download=True)

        def setup(self, stage: Optional[str] = None):

            # Assign train/val datasets for use in dataloaders
            if stage == "fit" or stage is None:
                mnist_full = MNIST(self.data_dir, train=True, transform=self.transform)
                self.mnist_train, self.mnist_val = random_split(mnist_full, [55000, 5000])

            # Assign test dataset for use in dataloader(s)
            if stage == "test" or stage is None:
                self.mnist_test = MNIST(self.data_dir, train=False, transform=self.transform)

            if stage == "predict" or stage is None:
                self.mnist_predict = MNIST(self.data_dir, train=False, transform=self.transform)

        def train_dataloader(self):
            return DataLoader(self.mnist_train, batch_size=32)

        def val_dataloader(self):
            return DataLoader(self.mnist_val, batch_size=32)

        def test_dataloader(self):
            return DataLoader(self.mnist_test, batch_size=32)

        def predict_dataloader(self):
            return DataLoader(self.mnist_predict, batch_size=32)
```

## prepare_data explanation
Downloading and saving data with multiple processes will result in corrupt data. Lightning ensures the `prepare_data()` is called only within a single process on CPU, so you can safely add your downloading lgic within. In case of multi-node training,  the execution of this hook depends upon `prepare_data_per_node ` `setup()` is called after `prepare_data` and there is a barrier in between which ensures that all the processes proceed to `setup` once the data is prepared and  available for use. It will only be executed once.

## setup explanation
There are also data operations you might want to perform on every GPU. Use `setup()` to do things like:
- count numbers of classes
- build vocabulary
- perform train/val/test splits
- create datasets
- apply transforms
- etc...
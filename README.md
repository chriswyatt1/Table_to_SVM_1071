# Run SVM on RNASeq data with Nextflow

This Nextflow pipeline is designed to run a simple SVM analysis on a basic table of gene expression counts with a table of features (such as queen/worker ids). See publication: https://www.nature.com/articles/s41467-021-21095-6 (Open access)

To start you need to go to the interactive gitpod environment for this repo (for this you need a github, gitlab or bitbucket account before starting). The gitpod environment is free to access, and currently you have 50 hours per month free for users of the mentioned git accounts.

1. To open the gitpod environment, click on the following URL: https://gitpod.io/#https://github.com/chriswyatt1/Table_to_SVM_1071/tree/Gitpod_testing

2. Then, log into your git hosting account.

3. Then in the terminal section (bottom right), you can run the demo with:
```
nextflow run main.nf -bg -profile docker
```
-->
Where, first we call `nextflow` to `run` the script called `main.nf`
Then we use the docker profile flag `-profile docker`, which tells Nextflow to use docker within this environment, where all the programs are available to run the repo code. 

4. Now you will see something similar to the following:
```
Launching `main.nf` [sad_liskov] - revision: 51169b9f2c
 S V M 
 P I P E L I N E
 ===================================
 input rnaseq data                    : /workspace/Table_to_SVM_1071/data/counts_clean_subsample.csv
 phenotypic data for each sample      : /workspace/Table_to_SVM_1071/data/phenotypic_data.csv
 out directory                        : results
 
[24/67c3d6] Submitted process > RUN_SVM (1)
```

--> Which shows that nextflow is running the demo data. To check if it is still running you can use `top` and you should see a `java` and `R` process running (among others). This script should take an hour to run. 

--> You can check where the program is running by looking in the `work` directory, and above you can see the start of the working folder : work/24/67c3d6.............  (press tab to complete folder name- default hex numbers). In this directory use `ls -lath` to see the working files, such as .command.sh , which contains the command to run:

```
#!/bin/bash -ue
demo.R counts_clean_subsample.csv phenotypic_data.csv
```

--> Check .command.out  in the same work directory, to see the actual R messages being written.

5. Once the pipeline is finished it will print the following message to screen:

```

```

6. Now you can try running the same repo on you own imported data. Though, in many cases this will be too computationally heavy for the 50 free hours. Therefore, we recommmend that you git clone this repo locally, or on a university cluster to run on large datasets. This will likely involve creating a new profile to submit jobs to a cluster. There is already another profile `-profile myriad` which shows a working example of a Sun Grid ENgine config (UCL myriad supercomputer) script which you can find in conf/myriad.config. Find more info about setting the config with your computational helpdesk or check public repos e.g. https://github.com/nf-core/configs/tree/master/conf

# Info for testing only
To use R in docker , pull this repo and execute R using (should take 5 mins to download):

```
docker run -it --rm chriswyatt/svm1071deseq2limma R
```

# Taylor-et-al-2020-demo

This repo contains machine learning demo code and data for Taylor et al "The molecular basis of socially-mediated phenotypic plasticity in a eusocial paper wasp".

# System requirements

Requires R version v3.6+ with packages *tidyverse* v1.3+, *e1071* v1.7+, *DESeq2* v1.26+, *limma* v3.4+ & *pracma* v2.2+ installed.

Tested in Ubuntu v18.04.4 using R v3.6.3 running in RStudio v1.3.959.

# Installation guide

We provide three sets of gene expression data for use with the demo code:

  * *counts_raw* is the full set of gene expression data generated for the experiment
  * *counts_clean* is a 'cleaned' set of genes from which rows representing genes with low expression across all samples have been removed
  * *counts_clean_subsample* is a smaller set of 1000 genes randomly picked from those in *counts_clean*; we recommend using this smaller dataset to reduce computation times when testing the demo.
  
Each dataset is provided both as an RData object which can be loaded directly into R and also as a .csv file for export to other programs. Additionally, to use the demo you will need to load the object *phenotypic_data* which describes which samples belong to which treatment groups in addition to phenotypic data (the latter are not used in the present demo but are included in case they are of interest). 

# Demo & instructions for use

Once a gene expression data matrix and the phenotypic data matrix have been loaded into an R session, the demo code can be run without further intervention. As output, the demo produces:

 * Classifications and error estimates for a full svm model run using the full set of gene expression data provided
 * A rudimentary plot of the results of feature selection performed upon the provided dataset- this plot should possess a characteristic 'hockeystick' shape, with the error rates of the SVM models gradually decreasing at first then rapidly increasing once caste-informative features begin being removed
 * Classifications and error estimates for the optimised svm model produced using just the genes identified by feature selection as being caste-informative
 
 Note that the demo will likely take several hours to run on a desktop computer if the larger datasets provided are used. We recommend using the smaller subsample provided for testing the demo, which should take under an hour to run. This run time can be further reduced if the user modifies the demo to reduce the number of error estimates made in each loop of the feature selection process (set at 20 by default). Setting the number of loops to one will allow the demo to be run in under 10 minutes if using the subsetted data, but do note that the resulting error estimates will exhibit higher rates of stochasticity.  


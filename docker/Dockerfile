FROM mambaorg/micromamba:0.13.1

COPY R-base.yml R-base_micro.yml

RUN micromamba install -y -n base -f R-base_micro.yml && \
    micromamba clean --all --yes

RUN apt-get update && apt install -y procps g++ && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN Rscript -e "install.packages(c('BiocManager'), repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "BiocManager::install('limma')"
RUN Rscript -e "BiocManager::install('DESeq2')"
RUN Rscript -e "BiocManager::install('pracma')"
RUN Rscript -e "BiocManager::install('e1071')"
RUN Rscript -e "BiocManager::install('tidyverse')"

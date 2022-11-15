FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# Setup the Python's configs
RUN pip install --upgrade pip && \
    pip install --no-cache-dir pandas==0.23.4 numpy==1.16.3 && \
    pip install --no-cache-dir pybase64 && \
    pip install --no-cache-dir scipy && \
    pip install --no-cache-dir dask[complete] && \
    pip install --no-cache-dir dash==1.6.1 dash-core-components==1.5.1 dash-bootstrap-components==0.7.1 dash-html-components==1.0.2 dash-table==4.5.1 dash-daq==0.2.2 && \
    pip install --no-cache-dir plotly && \
    pip install --no-cache-dir adjustText && \
    pip install --no-cache-dir networkx && \
    pip install --no-cache-dir scikit-learn && \
    pip install --no-cache-dir tzlocal

# Setup the R configs
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN apt update
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt install -y r-base
RUN pip install rpy2==2.9.4
RUN apt-get -y install libxml2 libxml2-dev libcurl4-gnutls-dev libssl-dev
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'https://cran.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('BiocManager')"
RUN Rscript -e "BiocManager::install('ggplot2')"
RUN Rscript -e "BiocManager::install('DESeq2')"
RUN Rscript -e "BiocManager::install('RColorBrewer')"
RUN Rscript -e "BiocManager::install('ggrepel')"
RUN Rscript -e "BiocManager::install('factoextra')"
RUN Rscript -e "BiocManager::install('FactoMineR')"
RUN Rscript -e "BiocManager::install('apeglm')"

WORKDIR /
# Copy all the necessary files of the app to the container
COPY ./ ./

# Install the slider-input component
WORKDIR /slider_input
RUN pip install --no-cache-dir slider_input-0.0.1.tar.gz

WORKDIR /
EXPOSE 8050

# Launch the app
CMD ["python", "./app.py"]

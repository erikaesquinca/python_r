FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# Setup the Python's configs
RUN pip install --upgrade pip && \
    pip install --no-cache-dir pandas==1.4.4 && \
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
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                 littler \
         r-base \
         r-base-dev \
         r-recommended \
    && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r


WORKDIR /
# Copy all the necessary files of the app to the container
COPY ./ ./

# Install the slider-input component
WORKDIR /slider_input
RUN pip install --no-cache-dir slider_input-0.0.1.tar.gz

WORKDIR /
EXPOSE 8050

# Launch the app
CMD [""]

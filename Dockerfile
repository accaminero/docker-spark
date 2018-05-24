FROM gettyimages/spark
MAINTAINER Agustin C. Caminero

RUN apt-get update \
 && apt-get install -y nano wget bzip2\
 && apt-get clean

# Install Anaconda (which includes Jupyter)
RUN wget https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh \
 && /bin/bash ./Anaconda2-5.0.1-Linux-x86_64.sh -b -p /opt/anaconda \ 
 && rm -rf Anaconda2-5.0.1-Linux-x86_64.sh
RUN pip install findspark

 
# Disable token authentication for Jupyter Notebook
RUN mkdir -p /root/.jupyter
RUN touch /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py

# Set Environment Variable to use ipython with PySpark
RUN echo 'Set environment variables'
RUN mkdir -p /media/notebooks
ENV PYSPARK_PYTHON /opt/anaconda/bin/python
ENV PATH $PATH:/opt/anaconda/bin


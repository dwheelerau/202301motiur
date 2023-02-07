#To build this file:
#sudo docker build -f Dockerfile . -t dwheelerau/hawkweed:ubuntu2004

#To run this, mounting your current host directory in the container directory,
# at /project, and excute the check_installtion script which is in your current
#To push to docker hub:
#sudo docker push dwheelerau/marsupial:ubuntu2004

# Pull base image with gpu.
FROM nvidia/cuda:11.2.0-cudnn8-devel-ubuntu20.04
MAINTAINER Dave Wheeler NSWDPI

# Set up ubuntu dependencies and include vim for editing
RUN apt-get update -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata vim wget git build-essential git curl libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 && \
  rm -rf /var/lib/apt/lists/*

###### 
# Make the dir everything will go in
WORKDIR /build

# Intall anaconda 3.7 # hash: 22b14d52265b4e609c6ce78e2f2884b277d976b83b5f9c8a83423e3eba2ccfbe
ENV PATH="/build/miniconda3/bin:${PATH}"
ARG PATH="/build/miniconda3/bin:${PATH}"
RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py37_22.11.1-1-Linux-x86_64.sh &&\
	mkdir /build/.conda && \
	bash miniconda.sh -b -p /build/miniconda3 &&\
	rm -rf miniconda.sh

# do this
RUN conda --version

# copy now but update to clone once stored as repo
# RUN git clone https://github.com/dwheelerau/XXXXXX 
RUN mkdir -p /build/202301motiur
RUN ls
COPY yolov5 /build/202301motiur/yolov5 
COPY Test_Images_MacGregorsCreek /build/202301motiur/Test_Images_MacGregorsCreek

# check
RUN ls 202301motiur/

# install yolo dependencies
RUN cd /build/202301motiur/yolov5 && python -m pip install --upgrade pip && pip --version && pip install -r requirements.txt

CMD /bin/bash

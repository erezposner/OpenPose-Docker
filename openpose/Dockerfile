FROM nvcr.io/nvidia/pytorch:20.03-py3
WORKDIR /
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir /workspace/reqs
COPY environment_droplet.yml /workspace/reqs/
RUN conda env update --name base -f /workspace/reqs/environment_droplet.yml 
RUN /bin/bash -c "conda init bash"
RUN /bin/bash -c "source ~/.bashrc"

#RUN conda install -c conda-forge nodejs -y
RUN echo "conda activate base" >> ~/.bashrc

RUN echo "Installing dependencies..." && \
	apt-get -y --no-install-recommends update && \
	apt-get -y --no-install-recommends upgrade && \
	apt-get install -y --no-install-recommends \
	wget \
	build-essential \
	cmake \
	git \
	libatlas-base-dev \
	libprotobuf-dev \
	libleveldb-dev \
	libsnappy-dev \
	libhdf5-serial-dev \
	protobuf-compiler \
	libboost-all-dev \
	libgflags-dev \
	libgoogle-glog-dev \
	liblmdb-dev \
	pciutils \
	python3-setuptools \
	python3-dev \
	python3-pip \
	opencl-headers \
	ocl-icd-opencl-dev \
	libviennacl-dev \
	libcanberra-gtk-module \
	libopencv-dev && \
	python3 -m pip install \
	numpy \
	protobuf \
	opencv-python

RUN echo "Downloading and building OpenPose..." && \
	git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git && \
	mkdir -p /openpose/build && \
	cd /openpose/build && \
	cmake -DBUILD_PYTHON=ON .. && \
	make -j `nproc` 
	#wget -P /openpose/models/pose/coco/ https://github.com/foss-for-synopsys-dwc-arc-processors/synopsys-caffe-models/raw/master/caffe_models/openpose/caffe_model/pose_iter_440000.caffemodel


RUN cp /openpose/build/python/openpose/pyopenpose.cpython-37m-x86_64-linux-gnu.so /opt/conda/lib/python3.7/site-packages/pyopenpose.cpython-37m-x86_64-linux-gnu.so
RUN ln -s /opt/conda/lib/python3.7/site-packages/pyopenpose.cpython-37m-x86_64-linux-gnu.so pyopenpose

RUN mkdir /workspace/local_station
RUN mkdir /workspace/local_data
WORKDIR /workspace
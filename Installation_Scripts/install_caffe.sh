#!/bin/sh
# Script for installing Caffe with cuDNN support on Jetson TX2 Development Kits
# 3-19-17 JetsonHacks.com
# MIT License
# Install and compile Caffe on NVIDIA Jetson TX2 Development Kit
# Prerequisites (which can be installed with JetPack 3):
# L4T 27.1 (Ubuntu 16.04)
# OpenCV4Tegra
# CUDA 8.0
# cuDNN v5.1
# Tested last with Github Caffe commit: 317d162acbe420c4b2d1faa77b5c18a3841c444c
sudo add-apt-repository universe
sudo apt-get update -y
/bin/echo -e "\e[1;32mLoading Caffe Dependencies.\e[0m"
sudo apt-get install cmake -y
# General Dependencies
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev \
libhdf5-serial-dev protobuf-compiler -y
sudo apt-get install --no-install-recommends libboost-all-dev -y
# BLAS
sudo apt-get install libatlas-base-dev -y
# Remaining Dependencies
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev -y
sudo apt-get install python-dev python-numpy -y

sudo usermod -a -G video $USER
/bin/echo -e "\e[1;32mCloning Caffe into the home directory\e[0m"
# Place caffe in the home directory
cd $HOME
# Git clone Caffe
git clone https://github.com/BVLC/caffe.git 
cd caffe 
cp Makefile.config.example Makefile.config
# If cuDNN is found cmake uses it in the makefile
# Regen the makefile; On 16.04, aarch64 has issues with a static cuda runtime
cmake -DCUDA_USE_STATIC_CUDA_RUNTIME=OFF
# Include the hdf5 directory for the includes; 16.04 previously had issues for some reason
# The TX2 seems to handle this correctly now
# echo "INCLUDE_DIRS += /usr/include/hdf5/serial/" >> Makefile.config
/bin/echo -e "\e[1;32mCompiling Caffe\e[0m"
make -j6 all
# Run the tests to make sure everything works
/bin/echo -e "\e[1;32mRunning Caffe Tests\e[0m"
make -j6 runtest
# The following is a quick timing test ...
# tools/caffe time --model=models/bvlc_alexnet/deploy.prototxt --gpu=0


sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev protobuf-compiler gfortran libjpeg62 libfreeimage-dev libatlas-base-dev git python-dev python-pip libgoogle-glog-dev libbz2-dev libxml2-dev libxslt-dev libffi-dev libssl-dev libgflags-dev liblmdb-dev python-yaml

sudo easy_install pillow
cd ~/caffe

cat python/requirements.txt | xargs -L 1 sudo pip install
sudo ln -s /usr/include/python2.7/ /usr/local/include/python2.7
sudo ln -s /usr/local/lib/python2.7/dist-packages/numpy/core/include/numpy/ /usr/local/include/python2.7/numpy
cp Makefile.config.example Makefile.config
echo "Please make some changes on Makefile.config as required"
make pycaffe
make all
make test



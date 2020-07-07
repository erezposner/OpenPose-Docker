# OpenPose-Docker
A docker build file for CMU openpose with Python API support

# Requirements
Nvidia Docker runtime: https://github.com/NVIDIA/nvidia-docker#quickstart
CUDA 10.0 or higher on your host, check with nvidia-smi
Portainer

# How to build it?
Just run .sh file

# How to work with it?
OpenPose folder will be stored at /opt/openpose 
Binaries already copied to conda "base" environment and therefore to use Python API one should just import openpose as follows:
``` import pyopenpose```

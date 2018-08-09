# Bhim Pipeline Container
# Morey Lab
# Automated Build - Step 1

FROM ubuntu:17.10
LABEL description="Ubuntu 17.10 OS + MRtrix3 installation"
LABEL maintainer="Arnav Pondicherry <arnavpon@rwjms.rutgers.edu>"

# (1) Install MRTrix
#   - IMPORTANT: use only 1 CPU, but increase Docker RAM usage to 5 GB for installation
RUN echo "Installing MRtrix3 & its dependencies..." && echo && \
	apt-get update && apt-get install -y git g++ python python-numpy \
	libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev \
	libfftw3-dev libtiff5-dev && \
	git clone https://github.com/MRtrix3/mrtrix3.git && \
	cd mrtrix3 && \
	./configure && \
	echo && echo "Building MRtrix3 - expect this to take a while..." && echo && \
	NUMBER_OF_PROCESSORS=1 ./build -verbose && \
   	git describe --tags > /mrtrix3/mrtrix3_version.txt && \
	./set_path

# (2) Add /mrtrix3/bin to PATH (for tcsh)
ENV PATH=/mrtrix3/bin:$PATH

# (3) Start up tcsh
CMD ["tcsh"]

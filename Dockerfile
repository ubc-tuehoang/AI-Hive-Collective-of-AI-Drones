FROM ubuntu:latest

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHON_VERSION=3.8 \
    CSV_URL="http://blpd0.ssl.berkeley.edu/lband2017/AAA_candidates.v4_1492476400.csv"

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    wget \
    gnupg \
    curl \
    software-properties-common \
    python${PYTHON_VERSION} \
    python3-pip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN python3 -m pip install --trusted-host pypi.python.org \
#    requests \
#    langchain \
#    pymilvus \
#    ollama \
#    pypdf \
#    langchainhub \
#    langchain-community \
#    langchain-experimental
    
# Set the working directory
WORKDIR /app

COPY . /app

ARG DOWNLOAD_URL="https://ollama.com/install.sh"

RUN wget $DOWNLOAD_URL -O install1.sh && \
    chmod +x install1.sh && \
    ./install1.sh


# Download the CSV file
RUN wget $CSV_URL -O data.csv

#RUN gcc -o process-seti-data -pthread process-seti-data.c
#CMD ["./process-seti-data"]

# Command to run when the container starts
CMD [ "echo", "Successfully installed!" ]


########
#> docker build -t drone_ai .
#> docker run -it drone_ai /bin/bash
#> ollama serve &
###<press enter>
#> ollama list

###<to use Microsoft PHI3:medium>
#> ollama run phi3:medium --verbose

###<to use deepseek-coder:33b>
#> ollama run deepseek-coder:33b --verbose

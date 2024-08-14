FROM ubuntu:latest

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHON_VERSION=3.8 

## SETI data no longer avaliable
## CSV_URL="http://blpd0.ssl.berkeley.edu/lband2017/AAA_candidates.v4_1492476400.csv"


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
#RUN wget $CSV_URL -O data.csv

# Create the target directory
##RUN mkdir -p ./text_files_directory

# Move the CSV file to the target directory
#RUN mv data.csv ./text_files_directory/

#RUN gcc -o process-seti-data -pthread process-seti-data.c
#CMD ["./process-seti-data"]

# Command to run when the container starts
CMD [ "echo", "Successfully installed!" ]


######## STEPS ###############

#(main)> pip install -r requirements.txt

#(main)> docker build -t drone_ai .
#(main)> docker run -it -p 11434:11434 drone_ai /bin/bash

#app> OLLAMA_HOST=0.0.0.0 ollama serve &
### WAIT for about 10 seconds before <press enter>

#app> ollama list
## should be empty

#app> ollama run llama3 --verbose
#(option)
#app> ollama run llama3.1 --verbose
#(option)
#app> ollama run mistral --verbose

## CREATE A NEW BASH
## curl commands for testing. 
#> curl -X POST http://localhost:11434/api/generate -d '{  "model": "llama3.1",  "prompt":"What is water?"}'
#> curl -X POST http://localhost:11434/api/generate -d '{  "model": "llama3",  "prompt":"What is water?"}'

#> python ./faiss-any-llm-feedback8.py llama3.1
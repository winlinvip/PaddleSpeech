FROM ubuntu:focal as dist

# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y gcc g++ make python3 python3-dev python3-venv libsndfile1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ADD requirements.txt entrypoint.sh /p/
WORKDIR /p

RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install -r requirements.txt

ADD demos /g/demos
WORKDIR /g
ENTRYPOINT ["/p/entrypoint.sh"]

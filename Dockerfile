FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        curl \
        wget \
        git \
        vim \
        build-essential \
        ca-certificates \
        software-properties-common \
        sudo \
        nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#INSTALAMOS PYTHON
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-dev python3-pip && \
    ln -sf /usr/bin/python3.10 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

RUN git clone https://github.com/JuanLuisHernandezTerron/reto_final_python_unir.git \
    && git clone https://github.com/JuanLuisHernandezTerron/development-environment-UNIR.git \
    && cd reto_final_python_unir \
    && git checkout main \
    && pip install --no-cache-dir -r requirements.txt 

#LE DAMOS PERMISOS DE EJECUCION AL FICHERO
RUN chmod +x /development-environment-UNIR/start.sh

WORKDIR /reto_final_python_unir

CMD ["/development-environment-UNIR/start.sh"]

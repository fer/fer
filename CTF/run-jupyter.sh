#!/bin/bash

# Run Jupyter notebook locally and browse externally to your VM

export PATH=~/.local/bin:$PATH

source functions.sh

LOCAL_IP=`getCurrentIp`

jupyter-notebook --ip $LOCAL_IP \
	--port 8888 \
	--NotebookApp.token='' \
	--NotebookApp.password=''

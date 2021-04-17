#!/bin/sh

LOCAL_IP=`ifconfig eth0 | grep 'inet ' | awk {'print $2'}` 

# Run locally, browse externally:

jupyter-notebook --ip $LOCAL_IP \
		 --port 8888 \
		 --NotebookApp.token='' \
		 --NotebookApp.password=''


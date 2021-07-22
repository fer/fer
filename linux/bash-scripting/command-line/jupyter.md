---
description: Install Jupyter on Linux via apt
---

# jupyter

### Update system

```text
sudo apt-get update
sudo apt install python3-pip -y
```

### `pip` upgrade

```text
sudo -H pip3 install --upgrade pip
pip install notebook
```

### Enable bash kernel

```text
pip install bash_kernel
python3 -m bash_kernel.install
```

### Run jupyter notebooks

```bash
#!/bin/bash

# Run Jupyter notebook locally and browse externally to your VM

export PATH=~/.local/bin:$PATH

source functions.sh # todo, remove/substitute

LOCAL_IP=`getCurrentIp`

jupyter-notebook --ip $LOCAL_IP \
	--port 8888 \
	--NotebookApp.token='' \
	--NotebookApp.password=''
```

```text
./run-jupyter.sh
```


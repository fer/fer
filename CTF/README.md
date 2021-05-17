# Install Jupyter on Ubuntu 20.04

## Update system

```
sudo apt-get update
sudo apt install python3-pip -y
```

## `pip` upgrade

```
sudo -H pip3 install --upgrade pip
pip install notebook
```

## Enable bash kernel

```
pip install bash_kernel
python3 -m bash_kernel.install
```

## Run jupyter notebooks

```
./run-jupyter.sh
```
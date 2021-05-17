# ctf-writeups

- [ctf-writeups](#ctf-writeups)
  - [OverTheWire: Wargames](#overthewire-wargames)
  - [Install Jupyter on Linux via `apt`](#install-jupyter-on-linux-via-apt)
    - [Update system](#update-system)
    - [`pip` upgrade](#pip-upgrade)
    - [Enable bash kernel](#enable-bash-kernel)
    - [Run jupyter notebooks](#run-jupyter-notebooks)

- [OverTheWire: Wargames](#overthewire-wargames)

## OverTheWire: Wargames

The wargames offered by the [OverTheWire](https://overthewire.org/wargames/) community can help you to learn and practice security concepts in the form of fun-filled games.

Available Jupyter Notebooks:

- [Bandit](http://localhost:8888/notebooks/OTW/bandit.ipynb)
- [Natas](http://localhost:8888/notebooks/OTW/natas.ipynb)


## Install Jupyter on Linux via `apt`

### Update system

```
sudo apt-get update
sudo apt install python3-pip -y
```

### `pip` upgrade

```
sudo -H pip3 install --upgrade pip
pip install notebook
```

### Enable bash kernel

```
pip install bash_kernel
python3 -m bash_kernel.install
```

### Run jupyter notebooks

```
./run-jupyter.sh
```
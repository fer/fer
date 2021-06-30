# ctf-writeups

* [ctf-writeups](ctf.md#ctf-writeups)
  * [OverTheWire: Wargames](ctf.md#overthewire-wargames)
  * [Install Jupyter on Linux via `apt`](ctf.md#install-jupyter-on-linux-via-apt)
    * [Update system](ctf.md#update-system)
    * [`pip` upgrade](ctf.md#pip-upgrade)
    * [Enable bash kernel](ctf.md#enable-bash-kernel)
    * [Run jupyter notebooks](ctf.md#run-jupyter-notebooks)
* [OverTheWire: Wargames](ctf.md#overthewire-wargames)

## OverTheWire: Wargames

The wargames offered by the [OverTheWire](https://overthewire.org/wargames/) community can help you to learn and practice security concepts in the form of fun-filled games.

Available Jupyter Notebooks:

* [Bandit](http://localhost:8888/notebooks/OTW/bandit.ipynb)
* [Natas](http://localhost:8888/notebooks/OTW/natas.ipynb)

## Install Jupyter on Linux via `apt`

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

```text
./run-jupyter.sh
```


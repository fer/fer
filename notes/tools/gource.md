# Gource

Gource is a nice piece of software to generate animations based on your Git history.

## Install

```bash
apt install gource
```

## Run

Run this in your repository folder:

```bash
gource  --background 000000 --title "your title"  --font-size 18 --font-colour FFFF00  --hide bloom,filenames --key --file-idle-time 15  --camera-mode track  --disable-progress --user-friction
```

Convert the video to upload it to Youtube, Vimeo, etc.

```bash
ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i gource.ppm -crf 1 -threads 0 -bf 0 gource.mp4
```
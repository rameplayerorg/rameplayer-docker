# Docker Image for RamePlayer

Image is based on Alpine Docker image.

## Requirements

Install Docker.

## Running

For development you need a directory on your machine where you have cloned webui and backend repositories. In this example it is */home/user/projects/rameplayer*. You can mount also your video directory to be used, in this example it is */home/user/Videos*.

```sh
docker run -v /dev/snd:/dev/snd -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/user/projects/rameplayer:/opt/rame -v /home/user/Videos:/media/mmcblk0p1/media -p 8000:8000 -p 8080:80 -p 8022:22 --privileged rameplayerorg/rameplayer
```

WebUI can be found from following URLs:

http://localhost:8080/build

http://localhost:8080/src

## SSH

OpenSSH server is launched by supervisord, it listens to default port 22. Password for root: rpi

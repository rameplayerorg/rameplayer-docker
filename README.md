# Docker Image for RamePlayer

Image is based on Alpine Docker image.

## Requirements

Install Docker.

## Build

Run in cloned repository:
```sh
$ sudo docker build -t rameplayer .
```

This will take a bit time, so better to grab a coffee or coke meanwhile.

## Testing

```sh
sudo docker run -d -p 8080:80 -p 8000:8000 rameplayer
```

WebUI can be found from following URLs:

http://localhost:8080/build

http://localhost:8080/src

## Development

For development you need a directory on your machine where you have cloned webui and backend repositories. In this example it is */home/user/projects/rameplayer*:
```sh
sudo docker run -d -p 8080:80 -p 8000:8000 -v /home/user/projects/rameplayer:/opt/rame rameplayer
```

WebUI can be found from same URLs as in testing.

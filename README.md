# docker-cloudera-director

This project defines [Docker](https://www.docker.com/) images for running a [Cloudera Director Server](https://www.cloudera.com/products/product-components/cloudera-director.html) and (optionally) the client.

The [Dockery Hub tobyhferguson/cloudera-director](https://hub.docker.com/r/tobyhferguson/cloudera-director/) repo is the place to go figure out how to use this stuff. Here we just document how to build it.

Current version: **6.0.0**

## Caveats

Although I'm a developer who works on Cloudera Director, this is not an official Cloudera project, so do not expect support from Cloudera (or myself, potentially) for this project. Also, I'm not a Docker expert, so as usual, proceed with using this image at your own risk.

## Build Yourself

There are two Dockerfiles, one for the server (`server-Dockerfile`) and one for the client (`client-Dockerfile`), located in the root of this repo.

To build the images and tag them use:

```
docker build -f server-Dockerfile --tag tobyhferguson/cloudera-director:server_6.0.0 .
docker build -f client-Dockerfile --tag tobyhferguson/cloudera-director:client_6.0.0 .
```

## Ports
The server image exposes TCP port 7189, so be sure to publish the port when running. 

## Volumes

The directories `/home/director/db` (server only) and `/home/director/logs` (client and server) are declared as volumes in the image for storing the Director database and logs, respectively. Save these volumes across container runs to keep state and log history. See Docker documentation for how to manage them.

## Entrypoints and Working Directory

The client exposes the [cloudera director client](https://www.cloudera.com/documentation/director/latest/topics/director_client_run.html#concept_sk4_d2x_wr) `cloudera-director` as its entrypoint, using a working directory of `/project` on the client. 

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

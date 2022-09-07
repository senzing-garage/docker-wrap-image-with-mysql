# docker-wrap-with-mysql
Wrap a Docker image with enablement for MySQL database



## Create container

### XXX


1. Get versions of Docker images.
   Example:

    ```console
    curl -X GET \
        --output /tmp/docker-versions-stable.sh \
        https://raw.githubusercontent.com/Senzing/knowledge-base/main/lists/docker-versions-stable.sh
    source /tmp/docker-versions-stable.sh
    ```

1. List the Docker images and their
   [corresponding environment variable name](https://github.com/Senzing/knowledge-base/blob/main/lists/docker-versions-stable.sh).
   Example:

    ```console
    export BASE_IMAGES=( \
      "senzing/stream-loader;SENZING_DOCKER_IMAGE_VERSION_STREAM_LOADER" \
    )
    ```

1. Build each of the MySQL compatible docker images in the list.
   Example:

    ```console
    for BASE_IMAGE in ${BASE_IMAGES[@]}; \
    do \
        IFS=";" read -r -a BASE_IMAGE_DATA <<< "${BASE_IMAGE}"
        BASE_IMAGE_NAME="${BASE_IMAGE_DATA[0]}"
        BASE_IMAGE_VERSION_VARIABLE="${BASE_IMAGE_DATA[1]}"
        docker build \
            --build-arg BASE_IMAGE=${BASE_IMAGE_NAME}:${!BASE_IMAGE_VERSION_VARIABLE} \
            --tag ${BASE_IMAGE_NAME}-mysql:${!BASE_IMAGE_VERSION_VARIABLE} \
            https://github.com/Senzing/docker-wrap-with-mysql.git#issue-3.dockter.1

    done
    ```

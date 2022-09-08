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
   Format: `repository`;`tag`;`user` where user defaults to `1001`
   Example:

    ```console
    export BASE_IMAGES=( \
      "senzing/redoer;${SENZING_DOCKER_IMAGE_VERSION_REDOER:-latest};1001" \
      "senzing/senzing-api-server;${SENZING_DOCKER_IMAGE_VERSION_SENZING_API_SERVER:-latest}" \
      "senzing/senzing-console;${SENZING_DOCKER_IMAGE_VERSION_SENZING_CONSOLE:-latest}" \
      "senzing/senzing-poc-server:${SENZING_DOCKER_IMAGE_VERSION_SENZING_POC_SERVER:-latest}" \
      "senzing/sshd:${SENZING_DOCKER_IMAGE_VERSION_SSHD:-latest}" \
      "senzing/stream-loader;${SENZING_DOCKER_IMAGE_VERSION_STREAM_LOADER:-latest}" \
      "senzing/xterm:${SENZING_DOCKER_IMAGE_VERSION_XTERM:-latest}" \
    )
    ```

1. Build each of the MySQL compatible docker images in the list.
   Example:

    ```console
    for BASE_IMAGE in ${BASE_IMAGES[@]}; \
    do \
        IFS=";" read -r -a BASE_IMAGE_DATA <<< "${BASE_IMAGE}"
        BASE_IMAGE_NAME="${BASE_IMAGE_DATA[0]}"
        BASE_IMAGE_VERSION="${BASE_IMAGE_DATA[1]}"
        BASE_IMAGE_USER="${BASE_IMAGE_DATA[2]}"
        docker pull ${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION}
        echo docker build \
            --build-arg BASE_IMAGE=${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION} \
            --build-arg USER=${BASE_IMAGE_USER:-1001} \
            --tag ${BASE_IMAGE_NAME}-mysql:${BASE_IMAGE_VERSION} \
            https://github.com/Senzing/docker-wrap-image-with-mysql.git#issue-3.dockter.1

    done
    ```

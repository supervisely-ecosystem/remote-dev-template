IMAGE=python:3.8
PASS="debug"


docker pull $IMAGE && \
docker build --build-arg IMAGE=$IMAGE --build-arg PASS=${PASS} -f Dockerfile -t $IMAGE"-debug" . && \
docker run --rm -it -p 7777:22 --shm-size='1G' -e PYTHONUNBUFFERED='1' $IMAGE"-debug"

#     -f Dockerfile \
#     -t "${DOCKER_IMAGE}-debug" .

# && \

# docker build \
#     --build-arg DOCKER_IMAGE=${DOCKER_IMAGE} \
#     --build-arg DOCKER_IMAGE=${PASSWORD} \
#     -f Dockerfile \
#     -t "${DOCKER_IMAGE}-debug" . && \



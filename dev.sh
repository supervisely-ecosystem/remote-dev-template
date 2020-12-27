IMAGE=supervisely/base-py
PASS="debug"


cp ~/.ssh/id_rsa.pub id_rsa.pub 

docker pull $IMAGE && \
docker build --build-arg IMAGE=$IMAGE -t $IMAGE"-debug" . && \
docker run --rm -it -p 7777:22 --shm-size='1G' -e PYTHONUNBUFFERED='1' $IMAGE"-debug"

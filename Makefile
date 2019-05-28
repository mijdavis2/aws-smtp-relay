BUILD_IMAGE_TAG=aws-smtp-relay-build:latest
IMAGE_TAG=aws-smtp-relay:latest

docker-builder:
	docker build --tag ${BUILD_IMAGE_TAG} -f Dockerfile.build ./

docker-build-app-files: docker-builder
	docker run --rm -v (pwd)/target:/app/target -it ${BUILD_IMAGE_TAG} mvn compile assembly:single

docker-build-app-container:
	docker build --tag ${IMAGE_TAG} ./

docker-run-app:
	docker run --rm ${IMAGE_TAG}

#set -x
export IMG=hellogolang
export VERSION=0.0.0.1

echo ${IMG}
echo ${VERSION}

podman build --arch=amd64 -t ${IMG}:${VERSION}.amd64 -f Dockerfile
podman build --arch=arm64 -t ${IMG}:${VERSION}.arm64 -f Dockerfile

podman manifest create ${IMG}:${VERSION}
podman manifest add ${IMG}:${VERSION} containers-storage:localhost/${IMG}:${VERSION}.amd64
podman manifest add ${IMG}:${VERSION} containers-storage:localhost/${IMG}:${VERSION}.arm64

#set -x
export IMG=hellogolan=g
export VERSION=0.0.0.1

echo ${IMG}
echo ${VERSION}

podman manifest push ${IMG}:${VERSION} docker://registry.hub.docker.com/clarkezone/${IMG}:${VERSION}

echo podman search registry.hub.docker.com/clarkezone/${IMG} --list-tags

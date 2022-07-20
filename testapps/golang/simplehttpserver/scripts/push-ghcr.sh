#set -x
export IMG=hellogolang
export VERSION=0.0.0.1

echo ${IMG}
echo ${VERSION}

podman manifest push ${IMG}:${VERSION} docker://ghcr.io/clarkezone/${IMG}:${VERSION}

echo podman search ghcr.io/clarkezone/${IMG} --list-tags

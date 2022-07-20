To create a ghcr secret see https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry

To login to docker hub:
podman login registry.hub.docker.com -u <USERNAME>
podman login ghcr.io -u <USERNAME> 

TODO:
1. verify GHCR login and push
2. Script to create MCR
3. BICEP to create MCR
4. Script to push to MCR

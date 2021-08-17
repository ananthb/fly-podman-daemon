# Fly Podman Daemon

This is a Podman daemon that runs on [Fly](https://fly.io) and can be used to build OCI images using podman.

## Caveats
`podman build` works, but `podman run` has issues.

### Root-less podman
Running podman daemon as a non-root user works, but builds fail because podman expects subuid and subgid support. This seems to require some kernel support.

### Root podman
Podman running as root is the default experience currently. Containers are unable to run once more because of issues loading iptables modules. This might be configurable.

## Installation
1. Clone this repository.
2. `fly launch` & follow the prompts.
3. Select `n` when it asks if you want to deploy.
4. Create a volume in a region of your choice: `fly volumes create containers --size 50 --region sin`
5. Deploy

## Connect to podman remote
1. Create a WireGuard peer with `fly wireguard create`
2. Setup WireGuard with generated config.
3. `fly ips private` to get the IP of your daemon.
4. Set the `CONTAINER_HOST` env variable using that IP on TCP port 8080: `export CONTAINER_HOST=tcp://[]:8080`
5. On Linux, use `podman --remote` with the env var set to use the remove daemon. On MacOS, `brew install podman-remote`. Windows users can use podman-remote or install podman in WSL.

## Next Steps
1. Delete Docker Engine!
2. You almost definitely want to scale your remote daemon: `fly scale vm dedicated-cpu-2x`.

# LICENSE
podman-daemon is available under the [MIT License](./LICENSE) and is copyright (c) 2021 Ananth Bhaskararaman.

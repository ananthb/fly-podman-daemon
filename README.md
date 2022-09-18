# Fly Podman Daemon

This is a Podman daemon that runs on [Fly](https://fly.io) and can be used to build OCI images using podman. Podman runs as an unprivileged user inside the container. See [podman rootless](https://github.com/containers/podman/blob/main/rootless.md) for a list of caveats and gotchas. The majority of image builds will work fine in rootless podman.

Source Hut Mirror - [git.sr.ht/~ananth/fly-podman-daemon](https://git.sr.ht/~ananth/fly-podman-daemon)

## Installation
1. Clone this repository.
2. `fly launch` & follow the prompts.
3. Select `n` when it asks if you want to deploy.
4. Create a volume in a region of your choice: `fly volumes create containers --size 50 --region sin`
5. Deploy

## Connect to podman remote
1. Create a WireGuard peer with `fly wireguard create`
2. Setup WireGuard with generated config.
3. Set the `CONTAINER_HOST` env variable using the fly.io private network hostname on TCP port 8080: `export CONTAINER_HOST=tcp://appname.internal:8080`
4. On Linux, use `podman --remote` with the env var set to use the remove daemon. On MacOS, `brew install podman-remote`. Windows users can use podman-remote or install podman in WSL.

## Next Steps
1. Delete Docker Engine!
2. You almost definitely want to scale your remote daemon: `fly scale vm dedicated-cpu-2x`.

## LICENSE
podman-daemon is available under the [MIT License](./LICENSE) and is copyright (c) 2021-22 Ananth Bhaskararaman.


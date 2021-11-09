FROM docker.io/library/alpine:3.14.2
RUN apk --no-cache add podman ca-certificates fuse-overlayfs slirp4netns
RUN addgroup --system podman \
    && adduser --system --home /home/podman -G podman --shell /sbin/nologin podman \
    && echo 'podman:100000:65536' | tee /etc/subuid /etc/subgid
USER podman
COPY --chown=podman registries.conf /home/podman/.config/containers/registries.conf
VOLUME /home/podman/.local/share/containers
ENTRYPOINT ["podman"]
CMD ["system", "service", "tcp:[::]:8080", "-t0"]

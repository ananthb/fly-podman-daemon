FROM docker.io/library/alpine:3.14.2
RUN apk --no-cache add podman runc ca-certificates
RUN adduser --system --home /home/podman --shell /sbin/nologin podman \
    && echo 'podman:100000:65536' | tee /etc/subuid /etc/subgid
USER podman
COPY registries.conf /home/podman/.config/containers/registries.conf
VOLUME /home/podman/.local/share/containers
ENTRYPOINT ["podman", "--events-backend=none"]
CMD ["system", "service", "tcp:[::]:8080", "-t0"]

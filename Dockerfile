FROM docker.io/library/archlinux
RUN pacman -Syu --needed --noconfirm \
      podman runc ca-certificates \
    && pacman -Scc --noconfirm
VOLUME /var/lib/containers
ENTRYPOINT ["podman", "--events-backend=none"]
CMD ["system", "service", "tcp:[::]:8080", "-t0"]

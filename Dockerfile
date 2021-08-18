FROM docker.io/library/archlinux
RUN pacman -Syu --needed --noconfirm \
      podman runc ca-certificates \
    && pacman -Scc --noconfirm
VOLUME /var/lib/containers
RUN useradd --system --home-dir /var/lib/podman --create-home --shell /sbin/nologin podman \
    && touch /etc/subuid /etc/subgid \
    && usermod --add-subuids 100000-165535 --add-subgids 100000-165535 podman
USER podman
ENTRYPOINT ["podman", "--events-backend=none"]
CMD ["system", "service", "tcp:[::]:8080", "-t0"]

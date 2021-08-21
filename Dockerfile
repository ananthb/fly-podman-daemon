FROM docker.io/library/archlinux
RUN pacman -Syu --needed --noconfirm \
      podman runc ca-certificates \
    && pacman -Scc --noconfirm
COPY registries.conf /var/lib/podman/.config/containers/registries.conf
RUN useradd --system --home-dir /var/lib/podman --create-home --shell /sbin/nologin podman \
    && touch /etc/subuid /etc/subgid \
    && usermod --add-subuids 100000-165535 --add-subgids 100000-165535 podman \
    && chown -R podman:podman /var/lib/podman
USER podman
VOLUME /var/lib/podman/.local/share/containers
ENTRYPOINT ["podman", "--events-backend=none"]
CMD ["system", "service", "tcp:[::]:8080", "-t0"]

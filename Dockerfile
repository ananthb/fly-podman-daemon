FROM docker.io/library/archlinux
RUN pacman -Syu --needed --noconfirm \
      podman runc ca-certificates \
    && pacman -Scc --noconfirm
COPY registries.conf /home/podman/.config/containers/registries.conf
RUN useradd --system --home-dir /home/podman --shell /sbin/nologin podman \
    && touch /etc/subuid /etc/subgid \
    && usermod --add-subuids 100000-165535 --add-subgids 100000-165535 podman \
    && mkdir -p /home/podman/.local/share/containers \
    && chown -R podman:podman /home/podman
USER podman
VOLUME /home/podman/.local/share/containers
ENTRYPOINT ["podman", "--events-backend=none"]
CMD ["system", "service", "tcp:[::]:8080", "-t0"]

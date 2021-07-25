FROM docker.io/library/ubuntu:21.04
RUN apt-get update -qq \
    && apt-get install -yqq podman runc iptables ca-certificates \
    && apt-get clean
VOLUME /var/lib/containers
ENTRYPOINT ["podman", "--events-backend=none"]
CMD ["system", "service", "tcp:[::]:8080","-t0"]

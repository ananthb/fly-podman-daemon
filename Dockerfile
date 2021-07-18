FROM docker.io/library/ubuntu:21.04
RUN apt-get update -qq && apt-get install -yqq podman runc iptables ca-certificates
VOLUME /var/lib/containers
ENTRYPOINT ["podman"]
CMD ["system", "service", "tcp:[::]:8080","-t0"]

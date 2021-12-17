FROM centos:7
LABEL maintainer="Dovry"
ENV container=docker
ENV script_url "https://raw.githubusercontent.com/Dovry/ansible-install-script/master/ansible_convenience_script.sh"

# Install required packages
RUN yum makecache fast \
  && yum -y install wget locale-gen \
# Install ansible
  && wget --no-check-certificate -O - $script_url | bash -s -- -p \
  && yum clean all

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
HEALTHCHECK CMD ansible --version

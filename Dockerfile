FROM ubuntu:16.04
MAINTAINER JCole <jeremiah.coleman@daasnerds.com>

# Install Python and pip
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y python-minimal python-dev python-setuptools curl && \
  easy_install pip

# Install Ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc libffi-dev libssl-dev
RUN pip install ansible==2.6.0

# Cleanup
RUN apt-get clean && \
  rm -rf $HOME/.cache

# Run role tests
COPY . /etc/ansible/roles/ansible-role
WORKDIR /etc/ansible/roles/ansible-role
RUN ansible-playbook -i tests/inventory tests/test.yml --connection=local

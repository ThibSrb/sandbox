# CUSTOM
FROM fedora:latest
RUN dnf group install development-tools -y

# SSH
## Install OpenSSH server and utilities
RUN dnf -y install openssh-server sudo && \
    dnf clean all && \
    mkdir -p /var/run/sshd

## Create a sandbox user
RUN useradd -m sandbox && \
    echo "sandbox:password" | chpasswd

## Add it to sudo
RUN echo "sandbox ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

## Set password authentication for SSH
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

## Expose the SSH port
EXPOSE 22

## Use an entrypoint script to set the password at runtime
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

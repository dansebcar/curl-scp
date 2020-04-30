FROM debian:buster

RUN apt-get update && apt-get install --yes openssh-server openssl python3

ARG AUTHORIZED_KEY

RUN mkdir /run/sshd \
	&& useradd --create-home my-user --password "$(openssl passwd my-pass)"

ADD root /

ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd -E /var/log/sshd && bash"]

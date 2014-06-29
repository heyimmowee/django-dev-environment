# Tandoori dev environment docker file
# VERSION 0.0.1

FROM debian:wheezy
MAINTAINER Mowee « glamothe@tandoori.pro »

ENV DEBIAN_FRONTEND noninteractive

# Repos, system full update

RUN echo "deb http://ftp.fr.debian.org/debian/ wheezy main non-free contrib" > /etc/apt/sources.list
RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)

# System packages
RUN apt-get install -y -q wget net-tools python-pip python-software-properties sudo ssh nano git
RUN pip install virtualenvwrapper

# Tandoori deployment packages
RUN apt-get install -y -q libxml2 libxml2-dev libxml2-dev libxslt1-dev libpq-dev python-dev

# Postgresql installation
RUN wget --no-check-certificate https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key add ACCC4CF8.asc
RUN add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main"
RUN apt-get update && apt-get install -y postgresql-9.3 pgadmin3 postgresql-server-dev-9.3

# Create and configure a dev user
RUN adduser dev --home /home/dev/
WORKDIR /home/dev/
ENV WORKDIR /home/dev/
RUN (echo dev:password | chpasswd)
RUN echo "dev ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
ADD bashrc $WORKDIR.bashrc
ADD bash_aliases $WORKDIR.bash_aliases
RUN mkdir .ssh/
RUN touch $WORKDIR.ssh/known_hosts
RUN ssh-keyscan -H github.com >> $WORKDIR.ssh/known_hosts
ADD id_rsa $WORKDIR.ssh/id_rsa

# Build dev environment
RUN mkdir $WORKDIR.virtualenvs

# Give all the rights to dev from its home dir
RUN chown -R dev:dev /home/dev/ 

# Start required servicesh
RUN service postgresql start
RUN service ssh start

# Open VM port 8000 for runserver django cmd
EXPOSE 8000

# Entrypoint
CMD ["su", "dev"]
ENTRYPOINT ["/usr/bin/sudo"]
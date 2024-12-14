# Debian Strech is the latest release still providing Tcl 8.5
FROM debian/eol:stretch AS build

RUN sed -i '/stretch-updates/d' /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

RUN apt-get update

# Tcl 8.5 is the most recent supported version by OPAL
# Trying to compile it with 8.6 will lead to error "'Tcl_Interp' has no member named 'result'"
RUN apt-get -y install wget build-essential autoconf flex libreadline-dev tcl8.5-dev libx11-dev tk8.5-dev

WORKDIR /root

RUN wget https://web.archive.org/web/20151029050811/http://projects.uebb.tu-berlin.de/opal/trac/raw-attachment/wiki/OCS/ocs-2.4b.tar.gz
RUN test "$(sha256sum ocs-2.4b.tar.gz)" = "ddca8e1991345bd27886dba7a6f922b54be77f927828648973fd73b158dd39d5  ocs-2.4b.tar.gz"
RUN tar -zxvf ocs-2.4b.tar.gz
WORKDIR /root/ocs-2.4b

RUN ./configure
RUN make install

FROM debian/eol:stretch

COPY --from=build /opt/ocs-2.4b /opt/ocs-2.4b

RUN sed -i '/stretch-updates/d' /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install tcl8.5 libreadline7 git build-essential

WORKDIR /root

RUN echo 'export PATH="/opt/ocs-2.4b/bin:$PATH"' >> .bashrc

CMD [ "/bin/bash" ]


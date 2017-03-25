FROM microsoft/mssql-server-linux:latest
MAINTAINER Casey Petrus <cjpetrus@gmail.com>
LABEL description="ubuntu 16.04 Xenial running mssql + mssql-tools. automated db restore available"


ENV ACCEPT_EULA=Y
ENV LANG "en_US.UTF-8"
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# sql tools setup;
RUN locale-gen en_US.UTF-8 && update-locale
RUN apt-get update && apt-get install -y curl apt-transport-https
RUN rm -rf /etc/apt/sources.list && \
echo  deb http://archive.ubuntu.com/ubuntu xenial main multiverse universe  >> /etc/apt/sources.list  \
&& echo deb http://fr.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse  >> /etc/apt/sources.list  \
&& echo deb http://fr.archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse  >> /etc/apt/sources.list  \
&& echo deb http://fr.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse   >> /etc/apt/sources.list  \
&& echo deb http://fr.archive.ubuntu.com/ubuntu/ xenial-proposed main restricted universe multiverse  >> /etc/apt/sources.list  \
&& echo deb http://security.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse  >> /etc/apt/sources.list  \
&& echo deb http://archive.canonical.com/ubuntu/ xenial partner   >> /etc/apt/sources.list

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

RUN apt-get update  -y  && apt-get upgrade  -y
RUN apt-get -y install build-essential
RUN apt-get install -y mssql-tools
ADD ./entrypoint.sh /entrypoint.sh
RUN  chmod +x /entrypoint.sh
EXPOSE 1433
ENTRYPOINT ["/entrypoint.sh"]

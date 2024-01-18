ARG BASE_IMAGE=debian:11.6-slim@sha256:8eaee63a5ea83744e62d5bf88e7d472d7f19b5feda3bfc6a2304cc074f269269
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2023-03-16

LABEL Name="senzing/wrap-with-mysql" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

USER root

# Install packages via apt-get.

RUN export STAT_TMP=$(stat --format=%a /tmp) \
 && chmod 777 /tmp \
 && apt update \
 && apt -y install wget \
 && chmod ${STAT_TMP} /tmp

# MySQL support

RUN wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc_8.0.20-1debian10_amd64.deb \
 && wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-common_8.0.20-1debian10_amd64.deb \
 && wget http://repo.mysql.com/apt/debian/pool/mysql-8.0/m/mysql-community/libmysqlclient21_8.0.20-1debian10_amd64.deb \
 && apt-get update \
 && apt-get -y install \
      ./mysql-connector-odbc_8.0.20-1debian10_amd64.deb \
      ./mysql-common_8.0.20-1debian10_amd64.deb \
      ./libmysqlclient21_8.0.20-1debian10_amd64.deb \
 && rm \
      ./mysql-connector-odbc_8.0.20-1debian10_amd64.deb \
      ./mysql-common_8.0.20-1debian10_amd64.deb \
      ./libmysqlclient21_8.0.20-1debian10_amd64.deb \
 && rm -rf /var/lib/apt/lists/*

 RUN rm /opt/senzing/g2/sdk/python/senzing_governor.py || true

# Set/Reset the USER.

ARG USER=1005
USER ${USER}

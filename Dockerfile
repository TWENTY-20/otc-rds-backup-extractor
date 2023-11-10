# mysql version in otc
FROM mysql:8.0.25

ADD https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-8.0.25-17/binary/debian/buster/x86_64/percona-xtrabackup-80_8.0.25-17-1.buster_amd64.deb percona-xtrabackup-80_8.0.25-17-1.buster_amd64.deb

ADD https://repo.percona.com/percona/apt/pool/main/q/qpress/qpress_11-3.buster_amd64.deb qpress_11-3.buster_amd64.deb

COPY entry.sh .

# add new keys, since image is so old that it contains the old keys
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29
RUN apt update

RUN apt install -y -f ./qpress_11-3.buster_amd64.deb
RUN apt install -y -f ./percona-xtrabackup-80_8.0.25-17-1.buster_amd64.deb
RUN rm *.deb
RUN rm -rf /var/lib/mysql

ENTRYPOINT ["bash", "entry.sh"]

# apply mysql settings from otc
CMD ["mysqld", "--lower_case_table_names=1", "--sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION", "--default-time-zone=Europe/Berlin"]
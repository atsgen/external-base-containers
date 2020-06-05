FROM registry.access.redhat.com/ubi7/ubi:latest
ARG CONTAINER_NAME
ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG
ARG VENDOR_DOMAIN

LABEL name=$CONTAINER_NAME \
    summary="Contrail rsyslogd" \
    description="Contrail rsyslogd support"

COPY *.sh /
RUN /bin/bash -c 'for item in `ls /__*` ; do mv $item /${item:3} ; done'

RUN yum -y install rsyslog && \
    yum clean all -y && \
    rm -rf /var/cache/yum

# Copy configuration files
COPY rsyslog.conf /etc/
COPY rsyslog.d/*.conf /etc/rsyslog.d/

ENV RSYSLOGD_PIDFILE=/var/run/rsyslogd.pid
ENTRYPOINT ["/contrail-entrypoint.sh"]
CMD rsyslogd -n -f /etc/rsyslog.conf -i $RSYSLOGD_PIDFILE

ENV SERVICE_NAME=rsyslogd
LABEL $VENDOR_DOMAIN".service"=$SERVICE_NAME
LABEL $VENDOR_DOMAIN".container.name"=$CONTAINER_NAME

FROM atsgen/rabbitmq:3.7.26
ARG VENDOR_NAME
ARG VENDOR_DOMAIN

ARG CONTAINER_NAME
ARG CONTRAIL_CONTAINER_TAG
LABEL vendor=$VENDOR_NAME \
      version=$CONTRAIL_CONTAINER_TAG \
      release="5.1.0" \
      name=$CONTAINER_NAME \
      summary="Tungsten Fabric RabbitMQ" \
      description="Contrail Rabbitmq is the message bus that different Contrail processes subscribe to."

# Add required license as text file in Liceses directory
RUN mkdir /licenses
COPY licensing.txt /licenses/licensing.txt

COPY *.sh hostname_to_ip /
RUN /bin/bash -c 'for item in `ls /__*` ; do mv $item /${item:3} ; done'

#xxd is in the vim-common package.
RUN yum install -y bind-libs vim-common && \
    yum clean all -y && \
    rm -rf /var/cache/yum

ENTRYPOINT ["/contrail-entrypoint.sh"]
CMD ["rabbitmq-server"]

ENV CONTRAIL_VERSION=$CONTRAIL_CONTAINER_TAG
ENV SERVICE_NAME=rabbitmq
LABEL $VENDOR_DOMAIN".service"=$SERVICE_NAME
LABEL $VENDOR_DOMAIN".container.name"=$CONTAINER_NAME

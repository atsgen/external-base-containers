FROM atsgen/cassandra:3.11.6 
ARG VENDOR_NAME
ARG VENDOR_DOMAIN

ARG CONTAINER_NAME
ARG CONTRAIL_CONTAINER_TAG
LABEL vendor=$VENDOR_NAME \
      version=$CONTRAIL_CONTAINER_TAG \
      release="5.1.0" \
      name=$CONTAINER_NAME \
      summary="Contrail Cassandra DB" \
      description="Configuration database for Contrail Controller."

# Add required license as text file in Liceses directory
RUN mkdir /licenses
COPY licensing.txt /licenses/licensing.txt

COPY *.sh /
RUN /bin/bash -c 'for item in `ls /__*` ; do mv $item /${item:3} ; done' 

# solves warning: "jemalloc shared library could not be preloaded to speed up memory allocations
RUN echo "INFO: enabling repos" && \
    yum-config-manager --enable rhel-7-server-optional-rpms,rhel-7-server-extras-rpms,rhel-server-rhscl-7-rpms ; \
    yum clean metadata ; \
    yum install -y rh-varnish5-jemalloc && \
    yum clean all -y && \
    rm -rf /var/cache/yum 

ENTRYPOINT ["/contrail-entrypoint.sh"]
CMD ["cassandra", "-f"]

ENV CONTRAIL_VERSION=$CONTRAIL_CONTAINER_TAG
ENV SERVICE_NAME=cassandra
LABEL $VENDOR_DOMAIN".service"=$SERVICE_NAME
LABEL $VENDOR_DOMAIN".container.name"=$CONTAINER_NAME


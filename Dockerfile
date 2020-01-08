FROM ruby:alpine
LABEL maintainer="DigitalGaz <digitalgaz@hotmail.com>"

ARG EXPEDITOR_VERSION
ARG VERSION=4.18.51
ARG GEM_SOURCE=https://rubygems.org

# Allow VERSION below to be controlled by either VERSION or EXPEDITOR_VERSION build arguments
ENV VERSION ${EXPEDITOR_VERSION:-${VERSION}}

RUN mkdir -p /share && \
    apk add --update build-base libxml2-dev libffi-dev git openssh-client && \
    gem install --no-document --source ${GEM_SOURCE} --version ${VERSION} cinc-auditor-bin && \
    apk del build-base && \
    rm -rf /usr/local/bundle/cache/* /var/cache/apk/*

ENTRYPOINT ["cinc-auditor"]
CMD ["help"]
VOLUME ["/share"]
WORKDIR /share
FROM concourse/concourse-ci
# https://github.com/concourse/concourse/blob/master/ci/dockerfiles/concourse-ci/Dockerfile

RUN apt-get update && apt-get install curl wget bzr tree -y

ADD cf-cli/cf-cli_*_linux_x86-64.tgz /usr/bin/
ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 /usr/bin/jq
RUN chmod 775 /usr/bin/jq

ADD https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64.zip /tmp/
RUN unzip /tmp/spiff_linux_amd64.zip -d /usr/local/bin
RUN rm /tmp/spiff_linux_amd64.zip

# Install Go
RUN \
  mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

RUN go get github.com/bronze1man/yaml2json
RUN go get github.com/cloudfoundry-community/humanize-manifest

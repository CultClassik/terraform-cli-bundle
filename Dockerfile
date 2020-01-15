FROM golang

ENV GO111MODULE="on"
ENV GOPATH="$HOME/go"
ENV GOBIN="$HOME/go/bin"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV PATH="${GOPATH}:${GOBIN}:${PATH}"
ENV SRC_TF="https://github.com/hashicorp/terraform"
ENV SRC_IBX="https://github.com/infobloxopen/terraform-provider-infoblox"
ENV IBX_VER="1.0.1"

RUN mkdir -p ${GOBIN} &&\
    git clone ${SRC_TF} /tmp/tfsource &&\
    cd /tmp/tfsource &&\
    go install ./tools/terraform-bundle &&\
    git clone ${SRC_IBX} /tmp/ibxsource &&\
    cd /tmp/ibxsource &&\
    make build &&\
    mkdir -p ~/.terraform.d/plugins &&\
    cp terraform-provider-infoblox ~/.terraform.d/plugins/terraform-provider-infoblox_v${IBX_VER}

COPY terraform-bundle.hcl /tmp/

RUN ${GOBIN}/terraform-bundle package -plugin-dir ~/.terraform.d/plugins /tmp/terraform-bundle.hcl
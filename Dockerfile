FROM alpine

RUN apk add --update curl bash jq bc \
    && rm -rf /var/cache/apk/*

RUN cd /usr/local/bin \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

COPY autoscale.sh /bin/autoscale.sh
RUN chmod +x /bin/autoscale.sh

ENV INTERVAL 30
ENV LOGS HIGH

CMD ["bash", "/bin/autoscale.sh"]

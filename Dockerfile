FROM tsl0922/ttyd:alpine as ttyd

FROM alpine

LABEL maintainer="lwzm@qq.com"

COPY --from=ttyd /usr/bin/ttyd /bin/
COPY entrypoint.sh dstat /bin/
RUN apk add --no-cache python2 \
    && cd /usr/lib/python2* \
    && find . -name '*.pyo' -delete \
    && find . -name '*.py' -delete

EXPOSE 80

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "dstat" ]

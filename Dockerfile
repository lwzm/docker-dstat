FROM tsl0922/ttyd:alpine as ttyd

FROM alpine

LABEL maintainer="lwzm@qq.com"

COPY --from=ttyd /usr/bin/ttyd /bin/
COPY entrypoint.sh /bin/
ADD https://github.com/dagwieers/dstat/raw/0.7.3/dstat /bin/
RUN chmod +x /bin/dstat && apk add --no-cache python2 && find /usr -name '*.pyc' -delete

EXPOSE 80

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "dstat" ]

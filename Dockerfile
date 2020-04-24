FROM lwzm/ttyd

LABEL maintainer="lwzm@qq.com"

RUN apk add --no-cache python2 \
    && cd /usr/lib/python2* \
    && find . -name '*.pyo' -delete \
    && find . -name '*.py' -delete

COPY dstat /bin/

CMD [ "dstat" ]

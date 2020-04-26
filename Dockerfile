FROM lwzm/ttyd

LABEL maintainer="lwzm@qq.com"

COPY dstat /bin/

RUN apk add --no-cache python2 \
    && cd /usr/lib/python2* \
    && rm -r ensurepip \
    && find . -name '*.py?' -delete \
    && dstat 1 1 \
    && find . -name '*.py' -delete

CMD [ "dstat", "-fclmgdrny", "--color" ]

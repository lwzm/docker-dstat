FROM alpine:3.5

LABEL maintainer="lwzm@qq.com"

ENV PYTHONOPTIMIZE=1

COPY dstat /bin/

RUN apk add --no-cache python2 \
    && cd /usr/lib \
    && mkdir tmp && mv lib* tmp && mv tmp/libpython* . && rm -r tmp \
    && cd /usr/lib/python2* \
    && rm -r idlelib lib2to3 config distutils ensurepip lib-dynload/unicodedata.so lib-dynload/_codecs_* wsgiref* \
    && find . -name '*.py?' -delete \
    && dstat 1 1 \
    && find . -name '*.py' -delete

CMD [ "dstat", "-fclmgdrny", "--color" ]

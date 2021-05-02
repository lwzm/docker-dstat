FROM alpine:3.5

LABEL maintainer="lwzm@qq.com"

ENV PYTHONOPTIMIZE=1

COPY dstat /bin/

RUN apk add --no-cache python2 lsof \
    && cd /usr/lib \
    && mkdir tmp && mv lib* tmp && mv tmp/libpython* . && rm -r tmp \
    && cd /usr/lib/python2* \
    && mv encodings lib-dynload .. \
    && rm -r $(ls -d */) \
    && mv ../encodings ../lib-dynload . \
    && find . -name '*.py?' -delete \
    && ( dstat 1 5 >/dev/null & sleep 1 && mv $(lsof -p $! | grep lib-dynload/ | awk '{print $8}') . && wait ) \
    && rm lib-dynload/* \
    && mv *.so lib-dynload/ \
    && find . -name '*.py' -delete \
    && find . -not -name '*.pyo' -maxdepth 1 -type f -delete \
    && apk del lsof

CMD [ "dstat", "-fclmgdrny", "--color" ]

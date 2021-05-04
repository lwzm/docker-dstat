FROM alpine:3.5 as base

COPY dstat /bin/
RUN apk add --no-cache python2 lsof
RUN find /usr/lib/python2* -name '*.py?' -delete \
    && (dstat 1 5 >/dev/null & sleep 1 && lsof -F n -p $! | grep lib-dynload/ | cut -d ' ' -f 1 | cut -c 2- && wait \
		&& find /usr/lib/python2* -name '*.py?' && ls /usr/lib/libpython* /usr/bin/python* /bin/dstat) \
	| cpio -dp /tmp


FROM alpine:3.5

LABEL maintainer="lwzm@qq.com"

CMD [ "dstat", "-fclmgdrny", "--color" ]

COPY --from=base /tmp /

FROM alpine:3.5 as base

RUN apk add --no-cache python2 lsof
COPY dstat /bin/
RUN find /usr/lib/python2* -name '*.py?' -delete \
    && (dstat 1 5 >/dev/null & sleep 1 && lsof -F n -p $! | grep ^fmem -A 1 | grep ^n | cut -d ' ' -f 1 | cut -c 2- && wait \
		&& find /usr/lib/python2* -name '*.py?' && ls /usr/bin/python* /bin/dstat /etc/passwd) \
	| cpio -dp /x/


FROM scratch

LABEL maintainer="lwzm@qq.com"

ENTRYPOINT [ "dstat", "--color" ]
CMD [ "-fclmgdrny" ]

COPY --from=base /x/ /

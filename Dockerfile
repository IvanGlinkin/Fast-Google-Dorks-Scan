FROM bash:5.1-alpine3.17

RUN apk add --no-cache curl
ADD --chmod=0755 FGDS.sh ./FGDS.sh
ENTRYPOINT ["bash", "./FGDS.sh"]

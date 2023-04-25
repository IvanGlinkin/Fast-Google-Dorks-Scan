FROM alpine:latest

RUN apk update && apk add --no-cache bash curl
COPY . . 
RUN chmod 755 ./FGDS.sh
ENTRYPOINT ["./FGDS.sh"]

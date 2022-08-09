FROM kalilinux/kali-rolling
RUN apt update -y && apt -y install curl
COPY . . 
RUN chmod 755 ./FGDS.sh
ENTRYPOINT ["./FGDS.sh"]
FROM ubuntu
RUN apt update -y && apt install -y python3 pip cron
RUN pip install humblebundle-downloader

WORKDIR /home
COPY trove_downloader /bin
COPY deploy.sh ./
CMD ./deploy.sh
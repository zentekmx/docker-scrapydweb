FROM python:3.6-alpine
LABEL maintainer="Zentek Servicios Tecnologicos"
LABEL description="Web app for Scrapyd cluster management, Scrapy log analysis & visualization, Auto packaging, Timer tasks, Monitor & Alert, and Mobile UI."

ENV PYTHONUNBUFFERED 1

RUN set -ex && apk --no-cache --virtual .build-deps add build-base g++ bash curl gcc libgcc tzdata psutils linux-headers openssl-dev libffi-dev libxml2-dev libxslt-dev

RUN ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
RUN echo "America/Mexico_City" > /etc/timezone

RUN pip install pip==20.2.4
RUN pip install scrapydweb

RUN mkdir /scrapyd
COPY scrapydweb_settings_v10.py /scrapyd/
WORKDIR /scrapyd/

EXPOSE 5000

ENTRYPOINT ["scrapydweb"]

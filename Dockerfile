FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y python3-pip python3-dev supervisor \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

RUN mkdir code
RUN mkdir /var/log/supervisord
ADD flask_server.py requirements.txt service.py /code/
WORKDIR /code
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN pip install -r requirements.txt
ENV FLASK_APP flask_server.py
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
EXPOSE 5000
#CMD ["flask", "run", "-h", "0.0.0.0"]

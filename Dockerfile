FROM python:3.6-alpine

ENV FLASK_APP flasky.py
ENV FLASK_CONFIG development

RUN adduser -D flasky
USER flasky

WORKDIR /home/flasky

COPY requirements requirements
RUN python -m venv venv
RUN venv/bin/pip install -r requirements/docker.txt

COPY app app
COPY migrations migrations
COPY flasky.py config.py boot_flasky.sh data-dev_sqlite ./

# run-time configuration
EXPOSE 5000
ENTRYPOINT ["./boot_flasky.sh"]

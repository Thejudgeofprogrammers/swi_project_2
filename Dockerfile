FROM swipl:latest

WORKDIR /app
COPY . /app

RUN mkdir -p /app/data

CMD ["swipl", "main.pl"]

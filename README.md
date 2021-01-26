Scrapydweb
==========

Web app for Scrapyd cluster management, Scrapy log analysis & visualization, Auto packaging, Timer tasks, Monitor & Alert, and Mobile UI.

This docker image is for scrapydweb in its own container. It accepts environment variables to update the configuration file.

Volumes are specified for for persistence.

# How to use this image

## Start a Scrapyd server

```console
$ docker run --name some-scrapydweb -d zentekmx/scrapydweb
```

Then, access it via `http://[docker host]:6800` in a browser.

The following environment variables are also honored for configuring your scrapydweb instance, these environment variables will update the scrapydweb config file.

-	`-e SCRAPYD_ADMIN=...` (defaults to "admin" - the username)
-	`-e SCRAPYD_PASSWD=...` (defaults to "secret" - the password)
-	`-e SCRAPYD_SERVERS=...` (defaults to "" - the container list in following format '[IP1]:6800,[IP2]:6800' or 'username:password@[IP1]:6801#group,username:password@[IP2]:6801#group,')
-	`-e SLACK_TOKEN=...` (defaults to "" - the slack token, see https://api.slack.com/apps)
-	`-e SLACK_CHANNEL=...` (defaults to "general" - the slack channel)
-	`-e TELEGRAM_TOKEN=...` (defaults to "" - the telegram token, see https://telegram.me/botfather)
-	`-e TELEGRAM_CHAT_ID=...` (defaults to "0" - the chat_id, see https://api.telegram.org/bot<TELEGRAM_TOKEN>/getUpdates)
-	`-e EMAIL_SUBJECT=...` (defaults to "Email from #scrapydweb" - the email subject)
-	`-e EMAIL_USERNAME=...` (defaults to "" - The email address)
-	`-e EMAIL_PASSWORD=...` (defaults to "" - The email password)
-	`-e EMAIL_SENDER=...` (defaults to "" - The email address if sender is different of EMAIL_USERNAME)
-	`-e SMTP_SERVER=...` (defaults to "" - The smtp server)
-	`-e SMTP_PORT=...` (defaults to 587 - The smtp port)
-	`-e SMTP_OVER_SSL=...` (defaults to False - Smtp server over ssl)
-	`-e ENABLE_MONITOR=...` (defaults to False - Launch poll subprocess to monitor your crawling jobs)
-	`-e ENABLE_SLACK_ALERT=...` (defaults to False - Enable to send slack alerts, it requires SLACK_ parameters)
-	`-e ENABLE_TELEGRAM_ALERT=...` (defaults to False - Enable to send telegram alerts, it requires TELEGRAM_ parameters)
-	`-e ENABLE_EMAIL_ALERT=...` (defaults to False - Enable to send email alerts, it requires EMAIL_ parameters)
-	`-e ALERT_WORKING_DAYS=...` (defaults to [] - When to send alert, Monday is 1 and Sunday is 7)
-	`-e ALERT_WORKING_HOURS=...` (defaults to [] - When to send alert, From 0 to 23.)
-	`-e ON_JOB_FINISHED=...` (defaults to False - Trigger alert when a job is finished)
-	`-e DATA_PATH=...` (defaults to "" - Where to save program data)
-	`-e DATABASE_URL=...` (defaults to "" - SQL backend, defaults SQLite)

## docker-compose

Example `docker-compose.yml` for `scrapyd`:

```yaml
version: '3'

services:

  scrapyd:
    image: zentekmx/scrapydweb
    ports:
      - 5000:5000

```

Run `docker-compose up`, wait for it to initialize completely, and visit `http://[docker host]:6800`.

### Deploying a project

Deploying your project involves eggifying it and uploading the egg to Scrapyd via the `addversion.json` endpoint.
The easiest way is to use the `scrapyd-deploy`. You can use following example:

1. Create egg file - Make sure you're in the root directory of the tutorial project, where the `scrapy.cfg` resides.

```console
scrapyd-deploy --build-egg <myproject>.egg
```

2. Deploy egg file version - change <myproject> with your project name

```console
curl http://[docker host]:6800/addversion.json -F project=<myproject> -F version=r1 -F egg=@<myproject>.egg
```

You can check the status of the project/spiders and logs on the scrapyd web GUI located at `http://[docker host]:6800`.

### Scheduling a spider

To schedule the execution of some spider, use the scrapyd API:

```console
curl http://[docker host]:6800/schedule.json -d project=<myproject> -d spider=<somespider>
```

# Feedback

## Issues

If you have any problems with or questions about this image, please file an issue on the [GitHub repository](https://github.com/zentekmx/docker-scrapyd/issues).

## Contributing

Pull requests welcome :-)

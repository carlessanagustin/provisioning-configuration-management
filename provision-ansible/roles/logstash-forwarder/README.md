# error log
$ tail -f /var/log/logstash-forwarder/logstash-forwarder.err


# default configuration JSON

{
  "network": {
    "servers": [
      "localhost:5043"
    ],
    "ssl certificate": "./logstash-forwarder.crt",
    "ssl key": "./logstash-forwarder.key",
    "ssl ca": "./logstash-forwarder.crt",
    "timeout": 15
  },
  "files": [
    {
      "paths": [
        "/var/log/messages",
        "/var/log/*.log"
      ],
      "fields": {
        "type": "syslog"
      }
    },
    {
      "paths": [
        "-"
      ],
      "fields": {
        "type": "stdin"
      }
    },
    {
      "paths": [
        "/var/log/apache/httpd-*.log"
      ],
      "fields": {
        "type": "apache"
      }
    }
  ]
}
# Speedwatch2

## What this is

This is a set of shell and R scripts, that measures internet speed and serves
the data on a website. It relies on [speedtest-cli] by sivel.

[speedtest-cli]: https://github.com/sivel/speedtest-cli "speedtest-cli"

## How to use this

Edit the top of `speedwatch.sh` to your needs and let it be called by cron or
similar. Put the the `webclient` directory somewhere on your Webserver, edit
the header of `json.php` (and `csv.php` if you need it). Call the directory
from your Browser.

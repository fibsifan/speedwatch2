# Speedwatch2

## What this is

This is a set of shell and R scripts, that measures internet speed and serves
the data on a website. It relies on [speedtest-cli] by sivel.

## How to use this

Edit the top of `speedwatch.sh` to your needs and let it be called by cron or
similar. Put the the `webclient` directory somewhere on your Webserver, edit
the header of `json.php` (and `csv.php` if you need it). Call the directory
from your Browser.

## License

Copyright (c) 2015 Johannes Ballmann. See `LICENSE` for details. Except:

* [c3.js][c3js], which is (c) [Masayuki Tanaka][masayuki0812],
  see [there][c3jslicense]
* [d3.js][d3js], which is (c) [Michael Bostock][mbostock],
  see [there][d3jslicense]
* [Bootstrap][bootstrap], which is (c) [Twitter, Inc.][twitter],
  see [there][bootstraplicense]
* [jQuery][jquery], which is (c) [jQuery Foundation][jQuery Foundation],
  see [there][jquerylicense]

[speedtest-cli]: https://github.com/sivel/speedtest-cli
  "speedtest-cli"
[c3js]: http://c3js.org
  "c3.js"
[c3jslicense]: https://github.com/masayuki0812/c3/blob/master/LICENSE
  "there"
[masayuki0812]: https://github.com/masayuki0812
  "Masayuki Tanaka"
[d3js]: http://d3js.org
  "d3.js"
[d3jslicense]: https://github.com/mbostock/d3/blob/master/LICENSE
  "there"
[mbostock]: http://bost.ocks.org/mike/
  "Michael Bostock"
[bootstrap]: http://getbootstrap.com/
  "Bootstrap"
[bootstraplicense]: https://github.com/twbs/bootstrap/blob/master/LICENSE
  "there"
[twitter]: https://about.twitter.com/company
  "Twitter, Inc."
[jquery]: http://jquery.com/
  "jQuery"
[jquerylicense]: https://github.com/jquery/jquery/blob/master/LICENSE.txt
  "there"
[jQuery Foundation]: https://jquery.org/
  "jQuery Foundation and other contributors"

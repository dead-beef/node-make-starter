# Node Make Starter

[![license](https://img.shields.io/github/license/dead-beef/node-make-starter.svg)](
    https://github.com/dead-beef/node-make-starter/blob/master/LICENSE
)

## Overview

Front-end starter kit based on NodeJS and Make.

## Project structure

* `./src` - application
  * `./src/js` - scripts
  * `./src/umd` - [UMD](https://github.com/umdjs/umd) scripts
  * `./src/css` - stylesheets (scss files are compiled to application css bundle)
    * `./src/css/main.scss` - main application stylesheet
    * `./src/css/vendor.scss` - main vendor stylesheet
    * `./src/css/_materialize.scss` - MaterializeCSS variables
  * `./src/img` - images
* `./build` - temporary build files
* `./dist` - bundled application
* `./tests` - unit tests
* `./config` - configuration
* `./make` - [makefiles](https://github.com/dead-beef/frontend-makediles)

## Requirements

- [`Node.js`](https://nodejs.org/)
- [`NPM`](https://nodejs.org/)
- [`GNU Make`](https://www.gnu.org/software/make/)
- [`Git`](https://git-scm.com/)

## Installation

```
git clone --recursive https://github.com/dead-beef/node-make-starter.git
cd node-make-starter
make
```

## Building

```bash
# single run
make
# continuous
make watch
# single run, minify
make min
# continuous, minify
make min-watch
# rebuild
make rebuild
# rebuild, minify
make rebuild-min
```

## Testing

```bash
# unit, single run
make test
# unit, continuous
make test-watch
# test application bundle
TEST_BUNDLE=1 make test
# select browsers (default: Chromium)
TEST_BROWSERS="Firefox Chrome" make test
```

## Code Linting

```
make lint
```

## Server

```bash
# start/restart
make start
# set ip and port
make SERVER_IP=127.0.0.1 SERVER_PORT=1080 start
# stop
make stop
```

## Licenses

* [`node-make-starter`](LICENSE)

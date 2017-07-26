# Node Make Starter

## Overview

Front-end starter kit based on NodeJS and Make.

## Project structure

* `./src` - application
  * `./src/js` - scripts
  * `./src/umd` - [UMD](https://github.com/umdjs/umd) scripts
  * `./src/css` - stylesheets (scss files are compiled to application css bundle)
    * `./src/css/main.scss` - main application stylesheet
    * `./src/css/vendor.scss` - main vendor stylesheet
    * `./src/css/_materialize_variables.scss` - MaterializeCSS variables
  * `./src/img` - images
* `./build` - temporary build files
* `./dist` - bundled application
* `./tests` - unit tests
* `./config` - configuration
  * `./config/os.mk` - shell commands
  * `./config/app.mk` - variables
  * `./config/deps.mk` - custom targets/dependencies

## Requirements

- [`Node.js`](https://nodejs.org/)
- [`NPM`](https://nodejs.org/)
- [`GNU Make`](https://www.gnu.org/software/make/)
- [`Git`](https://git-scm.com/)

## Installation

```
git clone https://github.com/dead-beef/node-make-starter.git
cd node-make-starter
make
```

## Building

Continuous

```
make watch
```

Single run

```
make
```

### Minification

Continuous

```
make watch-min
```

Single run

```
make min
```

## Testing

### Unit

Continuous

```
make test-watch
```

```
make test-watch-bundle
```

Single run

```
make test
```

```
make test-bundle
```

## Code Linting

```
make lint
```

## Licenses

* [`node-make-starter`](LICENSE)

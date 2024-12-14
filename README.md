# opal-container

Docker image for [OPAL](https://en.wikipedia.org/wiki/Opal_(programming_language)) development enviornment (the functional programming language developed by Peter Pepper et. al.)

Since OPAL is unmaintained it's getting harder to compile it on modern systems. This Dockerfile sets up a Debian Stretch container and compiles the latest/last available OPAL release (2.4b).

Within the container tools like `oasis` and `ocs` are available.

## Usage

### Building the container

    docker build -t opal .

### Starting the container

    docker run -ti opal

### Running opal-examples

Cloning, mounting and executing code from [opal-examples](https://github.com/stefanschramm/opal-examples):

    git clone https://github.com/stefanschramm/opal-examples.git
    docker run -ti -v ./opal-examples:/root/opal-examples opal
    cd opal-examples
    oasys
    a Funktionen
    f Funktionen.impl
    e ersterTest(2, 5)

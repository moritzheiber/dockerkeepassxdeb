# KeePassX 2.0 Dockerfile
Creates a [KeePassX 2.0](https://www.keepassx.org) binary deb distribution artifact, suitable for installation under Ubuntu (tested under Wily 15.10) and possibly Debian/variants.

Docker image uses Ubuntu Wily 15.10 as base with deb package produced using [checkinstall](http://asic-linux.com.mx/~izto/checkinstall/).

The current version is 2.0.2.

## Usage
With Docker installed and working on host system:

```sh
$ ./get_package.sh
```

Now wait for the image to be build. You'll find the package in the `/package` directory. Install it using `dpkg` by running:

```sh
§ sudo dpkg -i package/keepassx_*.deb
```

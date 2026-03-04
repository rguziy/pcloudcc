# pCloudCC Docker Build and Installation

This repository contains Dockerfile and build scripts to create `.deb` packages of pCloudCC for Ubuntu 16.04, 18.04, 20.04, 22.04, 24.04 and Debian 13.

## Using Pre-built .deb Packages

The `.deb` packages are already available in the `out` folder of this repository:

- `pcloudcc_2.0.1-ubuntu16_amd64.deb`
- `pcloudcc_2.0.1-ubuntu18_amd64.deb`
- `pcloudcc_2.0.1-ubuntu20_amd64.deb`
- `pcloudcc_2.0.1-ubuntu22_amd64.deb`
- `pcloudcc_2.0.1-ubuntu24_amd64.deb`
- `pcloudcc_2.0.1-debian13_amd64.deb`
  
If you do not want to run the Docker build, you can directly install these packages on your system:

```bash
sudo dpkg -i out/pcloudcc_2.0.0-1-ubuntu22_amd64.deb
```

Adjust the filename depending on your Ubuntu version.

## Building from Docker

Run the build script to build `.deb` packages for all supported Ubuntu versions:

```bash
./build.sh
```

This will create the following files in the `out` directory:

- `pcloudcc_2.0.1-ubuntu16_amd64.deb`
- `pcloudcc_2.0.1-ubuntu18_amd64.deb`
- `pcloudcc_2.0.1-ubuntu20_amd64.deb`
- `pcloudcc_2.0.1-ubuntu22_amd64.deb`
- `pcloudcc_2.0.1-ubuntu24_amd64.deb`
- `pcloudcc_2.0.1-debian13_amd64.deb`
- `libpcloudcc_lib.so` is included inside each `.deb`

## Install FUSE Library

If you are using Ubuntu 22.04 or 24.04, the `libfuse2` library is required to run `pcloudcc`. On Ubuntu 18.04 and 20.04 it is usually already installed. You can safely run the following command on all supported versions:

```bash
sudo apt update
sudo apt install libfuse2
```

This ensures that `libfuse.so.2` is available for `pcloudcc`. On older Ubuntu versions, APT will simply confirm it is already installed.

## Known Issues
### BAD_LOGIN_TOKEN after reinstall/recompile
If you see:
```bash
status is BAD_LOGIN_TOKEN
```
The stored authentication token may be invalid.
Fix:
```bash
rm -rf ~/.pcloud/
pcloudcc --user you@gmail.com --mountpoint /mnt/pcloud -p -s
```
This removes the old session data and forces a new login.

---

## License

MIT License


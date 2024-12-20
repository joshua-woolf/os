# JoshOS

This repository is a basic operating system setup based on [https://github.com/davidcallanan/os-series](os-series).

## Prerequisites

Docker and Qemu are required, install them using Homebrew:

```sh
brew bundle --file Brewfile
```

## Build and Run

Build the operating system in Docker and then run it in Qemu:

```sh
make all
```

## Cleanup

Cleanup the build artifacts:

```sh
make clean
```

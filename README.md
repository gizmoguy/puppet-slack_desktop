# slack_desktop

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with slack_desktop](#setup)
    * [What slack_desktop affects](#what-slack_desktop-affects)
    * [Beginning with slack_desktop](#beginning-with-slack_desktop)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This is a very simple Puppet module for installing the slack desktop client.

## Setup

### What slack_desktop affects

* Installs slack packagecloud repo and GPG keys.
* Installs slack-desktop package.
* Manages /etc/default/slack

### Beginning with slack_desktop

```puppet
include '::slack_desktop'
```

## Limitations

This module has been built on and tested against Puppet 3.x.

This module has been tested on:

* Ubuntu 16.04

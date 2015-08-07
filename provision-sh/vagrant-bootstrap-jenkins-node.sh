#!/usr/bin/env bash

# upgrading system
apt-get update
apt-get -y upgrade

# language settings
apt-get -y install language-pack-en
locale-gen UTF-8

# jenkins node requirements
apt-get -y install openjdk-7-jre openjdk-7-jdk

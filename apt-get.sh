#!/usr/bin/env bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo apt-get update
sudo apt-get install git
sudo apt-get install tldr
sudo apt-get install jq
sudo apt-get install ripgrep

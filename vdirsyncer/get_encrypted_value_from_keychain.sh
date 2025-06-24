#!/usr/bin/env bash

ENTRY_NAME=$1;
security find-generic-password -a $USER -s $ENTRY_NAME -w

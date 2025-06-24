#!/usr/bin/env bash

ICLOUD_USERNAME=$( security find-generic-password -a $USER -s aerc-goudjo-email-username -w )

EMAIL_ADDRESS=$( security find-generic-password -a $USER -s aerc-goudjo-email-address -w )

DOMAIN_NAME=$( echo $EMAIL_ADDRESS | cut -d @ -f 2 )

ICLOUD_USERNAME=$ICLOUD_USERNAME EMAIL_ADDRESS=$EMAIL_ADDRESS DOMAIN_NAME=$DOMAIN_NAME envsubst < ${PWD}/aerc/accounts.conf.tpl

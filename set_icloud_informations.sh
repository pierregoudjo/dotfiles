#!/usr/bin/env bash

USERNAME=$( gum input --placeholder "Icloud username" )
security add-generic-password -a $USER -s "aerc-goudjo-email-username" -w $USERNAME -U

PASSWORD=$( gum input --placeholder "Icloud password" )
security add-generic-password -a $USER -s "aerc-goudjo-email-password" -w $PASSWORD -U;

EMAIL_ADDRESS=$( gum input --placeholder "Personal email address" )
security add-generic-password -a $USER -s "aerc-goudjo-email-address" -w $EMAIL_ADDRESS -U;

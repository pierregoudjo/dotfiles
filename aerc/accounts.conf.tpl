[Personal]
source        = imaps://${ICLOUD_USERNAME}@imap.mail.me.com:993
outgoing      = smtp://${ICLOUD_USERNAME}@smtp.mail.me.com:587
default       = INBOX
from          = Pierre GOUDJO <${EMAIL_ADDRESS}>
aliases       = Pierre GOUDJO <*@${DOMAIN_NAME}>
use-envelope-from = true
source-cred-cmd = security find-generic-password -a $USER -s aerc-goudjo-email-password -w
outgoing-cred-cmd = security find-generic-password -a $USER -s aerc-goudjo-email-password -w
postpone      = Drafts
archive       = Archive
copy-to       = Sent Messages
enable-folders-sort = true
folders-sort  = INBOX,Drafts,Sent Messages,Archive
cache-headers = true
signature-file= ~/.config/aerc/signatures/default.txt

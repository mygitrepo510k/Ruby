# APNS.host = 'gateway.push.apple.com' 
APNS.host = 'gateway.sandbox.push.apple.com' 
# gateway.sandbox.push.apple.com is default

APNS.port = 2195 
# this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

APNS.pem  = "#{Rails.root}/config/apns_dev.pem"
# this is the file you just created

APNS.pass = '111111'
# Just in case your pem need a password
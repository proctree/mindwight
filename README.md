#mindwight
###What is it?

Mindwight is a simple command-line password safe(keychain) which allows for quick password manipulation.
It uses the fast TEA encryption algorithm(perl module written by Peter J Billiam http://www.pjb.com.au/comp/contact.html).

###Synopsys
Note: the bin directory contains both the binary and perl script, however, the examples use the binary.
####Adding a new password
`mindwight --add -n password_name -k key -p actual_password`
####Get a password from the safe
`mindwight --get -n password_name -k key`
####Remove a password
`mindwight --remove password_name`
####Search for a password
`mindwight --search search_term`

The documentation is available by running `mindwight --help`.

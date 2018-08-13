# Note this secret has to be same for company-web & company-api in order to make CSRF work
# As FE uses staging ENV for local testing, this should be in sync with Staging API Secret
export COMPANY_SECRET_KEY_BASE='b1f0ff90cd692556f9740a8e609f88f2f4fc15d9dda9035445a7577c3f94936eaae91a0793c4ad5500314fe5a526a3b3f7c7c71c303f883d903df138783a8225'

# Database details
export OCA_DEFAULT_DB_HOST=127.0.0.1
export OCA_DEFAULT_DB_USER=root
export OCA_DEFAULT_DB_PASSWORD=''

# Core ENV Details
export OCA_BASE_URL='https://securedhost.com'

# whitelisted_users
export OCA_WHITELISTED_USERS='mayur@ost.com akshay@ost.com preshita@ost.com'

# Google auth details
export OCA_GOOGLE_AUTH_KEY='1075579052937-tfa52mo9pc3rtpfr5500321l50clju25.apps.googleusercontent.com'
export OCA_GOOGLE_AUTH_SECRET='RNlmeLP8mMYonNoBw-X8GpvD'
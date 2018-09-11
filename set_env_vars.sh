# Note this secret has to be same for company-web & company-api in order to make CSRF work
# As FE uses staging ENV for local testing, this should be in sync with Staging API Secret
export OC_SECRET_KEY_BASE='b1f0ff90cd692556f9740a8e609f88f2f4fc15d9dda9035445a7577c3f94936eaae91a0793c4ad5500314fe5a526a3b3f7c7c71c303f883d903df138783a8225'

# Database details
export OCA_DEFAULT_DB_HOST=127.0.0.1
export OCA_DEFAULT_DB_USER=root
export OCA_DEFAULT_DB_PASSWORD='root'

# Base Url
export OC_BASE_URL='https://cms.developmentost.com'

# SHA256 Salt
export OCA_SHA256_SESSION_SALT='577c3f94936eaae91a0793c4ad5500314fe5a526a3b3f7c7c71c303f883d903df1'

# whitelisted_users
export OCA_WHITELISTED_USERS='mayur@ost.com akshay@ost.com preshita@ost.com'

# Google auth details
export OCA_GOOGLE_AUTH_KEY='1075579052937-tfa52mo9pc3rtpfr5500321l50clju25.apps.googleusercontent.com'
export OCA_GOOGLE_AUTH_SECRET='RNlmeLP8mMYonNoBw-X8GpvD'

# AWS Credentials
export OCA_AWS_ACCESS_KEY='AKIAJVUCQSK5GVPO5EDQ'
export OCA_AWS_SECRET_KEY='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'
export OCA_AWS_S3_BUCKET='wa.ost.com'
export OCA_AWS_REGION='us-east-1'

# cloudfront url
export OCA_CLOUDFRONT_URL='https://dxwfxs8b4lg24.cloudfront.net'

#web constants
export OCA_SUPPORTED_IMAGE_TYPES='image/png image/jpeg image/jpg'

# ost web information
export OCA_OST_URL='http://developmentost.com:8080/'

# Sha256 salt
export OCA_SHA256_SECRET_SALT='40a8e609f88f2f4fc15d9dda9035445a7577c3f94936eaae91a0793c'

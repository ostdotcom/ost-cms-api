source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.2.1'

# omniauth google
gem 'omniauth-google-oauth2'

# Rake
gem 'rake', '12.3.1'

# Mysql2
gem 'mysql2'

# hkdf for sha256
gem 'hkdf', '0.2.0'

# OJ
gem 'oj', '3.3.8'

# Sanitize input
gem 'sanitize', '4.5.0'

# Exception notifier
gem 'exception_notification', '4.2.2'

gem 'aws-sdk-s3', '1.5.0'

gem 'listen', '3.1.5'

group :development, :test do
  # Use Puma as the app server
  gem 'puma', '3.11.4'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'letter_opener'

  gem 'listen', '3.1.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

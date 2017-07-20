source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootstrap-kaminari-views"
gem "bootstrap-sass"
gem "cancancan"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "fog"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "kaminari"
gem "mini_magick"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-twitter"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.2"
gem "ransack"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "autoprefixer-rails"
  gem "better_errors"
  gem "brakeman", require: false
  gem "bundler-audit"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "database_cleaner"
  gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails", require: false
  gem "factory_girl_rails"
  gem "ffaker"
  gem "guard-rspec", require: false
  gem "jshint"
  gem "railroady"
  gem "rails_best_practices"
  gem "reek"
  gem "rspec"
  gem "rspec-collection_matchers"
  gem "rspec-rails"
  gem "rubocop", "~> 0.35.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "scss_lint", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "selenium-webdriver"
  gem "sqlite3"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "pg"
  gem "rails_12factor"
end

group :test do
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-json"
  gem "simplecov-rcov", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

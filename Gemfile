# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails-controller-testing'
gem 'spree', github: 'spree/spree', branch: 'main'
gem 'spree_backend', github: 'spree/spree_backend', branch: 'main'
gem 'spree_frontend', github: 'spree/spree_legacy_frontend', branch: 'main'

gem 'rave_ruby', github: 'nightcrawler-/rave-ruby', branch: 'develop'

if ENV['DB'] == 'mysql'
  gem 'mysql2'
else
  gem 'pg', '~> 1.1'
end

gemspec

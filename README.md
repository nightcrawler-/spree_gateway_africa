# Spree Gateway - Africa

[![Build Status](https://api.travis-ci.org/spree/spree_gateway.svg?branch=main)](https://travis-ci.org/spree/spree_gateway)
[![Code Climate](https://codeclimate.com/github/spree/spree_gateway.svg)](https://codeclimate.com/github/spree/spree_gateway)

Forked from Community supported Spree Payment Method Gateways. It works as a wrapper for
[active_merchant](https://github.com/activemerchant/active_merchant) gateway. 

Supported payment gateways:
* Flutterwave::Zambia Mobile Money
* Flutterwave::MPESA

For`PayPal` support head over to [braintree_vzero](https://github.com/spree-contrib/spree_braintree_vzero) extension.

## Installation

1. Add this extension to your Gemfile with this line:

    ```ruby
    gem 'spree_gateway', github: 'nightcrawler-/spree_gateway_africa', branch: 'main'

    ```

2. Install the gem using Bundler:
    ```ruby
    bundle install
    ```

3. Copy & run migrations
    ```ruby
    bundle exec rails g spree_gateway:install
    ```

Finally, make sure to **restart your app**. Navigate to *Configuration > Payment Methods > New Payment Method* in the admin panel and you should see that a bunch of additional gateways have been added to the list.

## Contributing

In the spirit of [free software][1], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* (You will need to `brew install mysql postgres` if you don't already have them installed)
* Run `bundle`
* (You may need to `bundle update` if bundler gets stuck)
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Make your changes
* Ensure specs pass by running `bundle exec rspec spec`
* (You will need to `brew install phantomjs` if you don't already have it installed)
* Submit your pull request


License
----------------------

The MIT License (MIT)

Copyright (c) 2022 Frederick Nyawaya

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

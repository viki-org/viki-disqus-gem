# Viki Disqus Gem

This is a gem used by the Viki web application for integrating Disqus
Single Sign-On (SSO). Users who log in to Viki can post comments on Disqus
using the same Viki account, without the need for another login.

## Installation

Add this line to your application's Gemfile:

    gem 'viki_disqus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install viki_disqus

## Usage

**NOTE:** You will have to read
http://help.disqus.com/customer/portal/articles/236206-integrating-single-sign-on
for setup instructions on the Disqus end.

You need to set these 2 environment variables to appropriate values:

* `DISQUS_SECRET_KEY`
* `DISQUS_PUBLIC_KEY`

They will be used by the VikiDisqus::SSO class.
Their values can be accessed through:

* `VikiDisqus::SSO::DISQUS_SECRET_KEY`
* `VikiDisqus::SSO::DISQUS_PUBLIC_KEY`

These functions are available publicly:

* `VikiDisqus::SSO::remote_auth_s3(optionsHash, timestampNow)`
* `VikiDisqus::SSO::signature(optionsHash, timestampNow)`
* `VikiDisqus::SSO::message(optionsHash)`

You should make use of the `VikiDisqus::SSO::remote_auth_s3` function
(which uses `VikiDisqus::SSO::signature` and
`VikiDisqus::SSO::message` internally).

You will need to embed this snippet of JavaScript, according to instructions
from Disqus. The template looks like:

```javascript
var disqus_config = function () {
    // The generated payload which authenticates users with Disqus
    this.page.remote_auth_s3 = '<message> <hmac> <timestamp>';
    this.page.api_key = 'public_api_key';
}
```

On the Viki web application, it looks like:

```javascript
var disqus_config = function () {
  this.page.remote_auth_s3 = '<%= VikiDisqus::SSO.remote_auth_s3(opts, Time.now.to_i) %>';
  this.page.api_key = '<%= VikiDisqus::SSO::DISQUS_PUBLIC_KEY %>';
}
```

## Running Tests

`bundle exec rspec spec`

or

`rspec spec`

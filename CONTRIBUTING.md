# Contributing to CodeKindly::Utils

Bug reports and pull requests are welcome on GitHub at https://github.com/jlw/codekindly-utils.

## Setup

`bundle install --path vendor`

## Run tests

To run tests against all supported Ruby versions and all supported major dependency versions:

```Shell
./all_rubies appraisal-install
./all_rubies appraisal-spec
```

## Submitting changes

1. Fork the repository
2. Make your code changes
3. Add complete test scenarios for your changes
4. Ensure your code follows the Ruby Style Guide: `bundle exec rubocop`
5. Submit a pull request on GitHub

## Publishing

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version of the gem to RubyGems.org:

```Shell
bundle exec rake install
gem push vendor/ruby/2.5.0/cache/codekindly-utils-x.y.z.gem
```

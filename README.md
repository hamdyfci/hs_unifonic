# HsUnifonic

Gem to send sms using unifonic API

## Configuration 

- server [ http://basic.unifonic.com]
- appsid
- method [wrapper or, rest] defualt is wrapper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hs_unifonic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hs_unifonic

## Usage

```ruby
HsUnifonic.send_sms(credentials, mobile_number, message,sender,options)
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hs_unifonic.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

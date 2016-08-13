# Eve

TODO: describe the  gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'the-eve'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install the-eve

## Usage

TODO: Write usage instructions here


### Asana
Asana client doesn't produce the token for us like GH, so, basically head to Asana web app 
* then profile settings
* apps
* `manage developer apps` at the bottom of the pop-up
* at `PERSONAL ACCESS TOKENS` section press: Create New Personal Access Token 
* type: "Eve".
* Press create.

Copy your token and save it in your preferable thingy.

Head to your shell and paste this command and runt it, `HINT` replace `<token>` with Asana Token:

`$echo "<token>" > ~/.eve_as`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ahmgeek/eve .


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


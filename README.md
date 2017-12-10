# NYPL Site Scraper

A (mechanize)[https://github.com/sparklemotion/mechanize] driven library for
getting information about your NYPL account by web scraping.

This library is an abstraction to get info from your account.
If you really want to concern yourself with markup, you're better off
using mechanize directly.

Examples of what it can get are your:

* Current Holds
* Fines
* Current Checkouts (not implemented yet)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nypl-site-scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nypl-site-scraper

## Usage

```ruby
client = NyplSiteScraper::Client.new(barcode: '11111111111111', pin: '2222')

client.login! # This is the network call

client.get_holds
# {"holds"=>[{"title"=>"Persepolis. English", "statusString"=>"READY FOR PICKUP", "status"=>"ready", "pickupLocation"=>"Mid-Manhattan Library at 42nd St"}...

client.get_fines
#{:fines=>[{:title=>"Zog and the flying doctors / by Julia Donaldson & illustrated by Axel Scheffler.", :fineAmount=>"$0.20"}...

client.get_checkouts
# {:checkouts => [{:title "Foo", dueDate: "Some date"}]}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nodanaonlyzuul/nypl-site-scraper.

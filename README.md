# MoreHoliday

Make more out of your holidays!

## Description

Use bridging days smartly, to have more value out of your given holiday days. This gem automatically suggests you, which days to reserve next time you ask your employer for vacation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'more_holiday'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install more_holiday

## Usage

This libary comes with german official holidays build in! So you just need to select your state and how many days you have available. Then you will get a suggestion, which days you should use, to take advantage from bridging days.

```ruby
MoreHoliday::Holiday.new("Berlin", available_days: 15).suggestions
```

Currently only german official holidays are supported. If you want to use select a different state or just want to play custom non official days, you can initialize with an ical file.

```ruby
MoreHoliday::Holiday.new(nil, available_days: 15, file_path: "/path/to/ical.ics").suggestions
```

## Export

It is possible to export the suggested days as a ical file as well, so you don't need to add them all manually to your calendar.

```ruby
MoreHoliday::Holiday.new("Berlin", available_days: 15).export_ical_file("/path/for/export")
# => "/path/for/export/MoreHoliday.ics"
```

## Next steps

- Add preference option, that suggestions are focused on specific time ranges
- Support more country states
- Add more import and export file content types
- Add browser support, that libary can be used with a stylish interface

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/freder1c/more_holiday. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MoreHoliday project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/freder1c/more_holiday/blob/master/CODE_OF_CONDUCT.md).

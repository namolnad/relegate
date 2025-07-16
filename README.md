# Relegate

A simple ActiveRecord archiving gem, forked from [jhawthorn/discard](https://github.com/jhawthorn/discard/tree/master) with additional configuration options.

Relegate provides methods and scopes to mark records as archived without deleting them. It integrates with ActiveRecord via an `archived_at` timestamp column (customizable).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "relegate"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install relegate
```

## Usage

Add `relegate` to your model:

```ruby
class YourModel < ApplicationRecord
  relegate
end
```

This will generate:

- `archived?` / `unarchived?` predicate methods
- `archive` / `unarchive` instance methods (non-bang and bang versions)
- `archive_all` / `unarchive_all` class methods
- `archived` / `unarchived` scopes

You can override the column name:

```ruby
class YourModel < ApplicationRecord
  relegate column_name: :discarded_at
end
```

This will generate equivalent methods and scopes using `discarded_at` instead of `archived_at`:
- `discarded?` / `not_discarded?` predicate methods
- `discard`, `not_discard` instance methods (non-bang and bang versions)
- `discard_all`, `not_discard_all` class methods
- `discarded`, and `not_discarded` scopes

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/namolnad/relegate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/namolnad/relegate/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Relegate project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/namolnad/relegate/blob/main/CODE_OF_CONDUCT.md).

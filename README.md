# SongPro [![Build Status](https://travis-ci.org/spilth/song_pro.svg?branch=master)](https://travis-ci.org/spilth/song_pro)

[SongPro](https://songpro.org) is a text format for transcribing songs.
 
This project is a Ruby Gem that converts the song into a Song data model which can then be converted into various output formats such as text or HTML.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'song_pro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install song_pro

## Usage

Given then file `bad-moon-rising.sng` with the following contents:

```
@title=Bad Moon Rising
@artist=Cleedence Clearwater Revival

# Intro

[D][A][G][D]

# Verse 1

[D]I see a [A]bad [G]moon a-[D]rising
[D]I see [A]trouble [G]on the [D]way
[D]I see [A]earth-[G]quakes and [D]lightnin'
[D]I see [A]bad [G]times to-[D]day
```

You can then parse the file to create a `Song` object:

```ruby
require 'song_pro'

text = File.read('bad-moon-rising.sng')
song = SongPro.parse(text)

puts song.title
# Bad Moon Rising

puts song.artist
# Creedence Clearwater Revival 

puts song.sections[1].title
# Verse 1

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/spilth/song_pro>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

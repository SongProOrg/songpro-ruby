# SongPro for Ruby ![Build](https://github.com/SongProOrg/songpro-ruby/workflows/Build/badge.svg?branch=main)

[SongPro](https://songpro.org) is a text format for transcribing songs.
 
This project is a Ruby Gem that converts the song into a Song data model which can then be converted into various output formats such as text or HTML.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'song_pro'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install song_pro
```

## Usage

Given then file `escape-capsule.sng` with the following contents:

```
@title=Escape Capsule
@artist=Brian Kelly
!bandcamp=https://spilth.bandcamp.com/track/escape-capsule-nashville-edition

# Verse 1

Climb a-[D]board [A]
I've been [Bm]waiting for you [F#m]
Climb a-[G]board [D]
You'll be [Asus4]safe in [A7]here

# Chorus 1

[G] I'm a [D]rocket [F#]made for your pro-[Bm]tection
You're [G]safe with me, un-[A]til you leave
```

You can then parse the file to create a `Song` object:

```ruby
require 'song_pro'

text = File.read('escape-capsule.sng')
song = SongPro.parse(text)

puts song.title
# Escape Capsule

puts song.artist
# Brian Kelly

puts song.sections[1].name
# Chorus 1

p song.chords
# ["D", "A", "Bm", "F#m", "G", "Asus4", "A7", "F#"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/SongProOrg/songpro-ruby>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

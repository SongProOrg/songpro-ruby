# frozen_string_literal: true

require 'song_pro/version'
require 'song_pro/song'
require 'song_pro/section'
require 'song_pro/line'
require 'song_pro/part'

module SongPro
  def self.parse(content)
    song = Song.new
    current_section = nil

    lines = content.split("\n")

    lines.each do |text|
      if text.start_with?('@')
        matches = /@(\w*)=([^%]*)/.match(text)
        key = matches[1]
        value = matches[2].strip

        case key
        when 'title'
          song.title = value
        when 'artist'
          song.artist = value
        else
          puts "WARNING: Unknown attribute '#{key}'"
        end
      elsif text.start_with?('#')
        matches = /#\s*([^$]*)/.match(text)
        name = matches[1].strip
        current_section = Section.new(name: name)
        song.sections << current_section
      else
        unless text == ''
          if current_section.nil?
            current_section = Section.new(name: '')
            song.sections << current_section
          end

          line = Line.new
          part = Part.new
          part.lyric = text
          line.parts << part
          current_section.lines << line
        end
      end
    end

    song
  end
end

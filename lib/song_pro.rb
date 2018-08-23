# frozen_string_literal: true

require 'song_pro/version'
require 'song_pro/song'
require 'song_pro/section'
require 'song_pro/line'
require 'song_pro/part'

module SongPro
  def self.parse(lines)
    song = Song.new
    current_section = nil

    lines.split("\n").each do |text|
      if text.start_with?('@')
        process_attribute(song, text)
      elsif text.start_with?('#')
        current_section = process_section(song, text)
      else
        process_lyrics_and_chords(song, current_section, text)
      end
    end

    song
  end

  private

  def self.process_section(song, text)
    matches = /#\s*([^$]*)/.match(text)
    name = matches[1].strip
    current_section = Section.new(name: name)
    song.sections << current_section

    current_section
  end

  def self.process_attribute(song, text)
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
  end

  def self.process_lyrics_and_chords(song, current_section, text)
    return if text == ''

    if current_section.nil?
      current_section = Section.new(name: '')
      song.sections << current_section
    end

    line = Line.new

    captures = text.scan(/(\[\w+\])?([\w\s'_\-"]*)/i).flatten

    captures.each_slice(2) do |pair|
      part = Part.new
      chord = pair[0]&.strip || ''
      part.chord = chord.gsub('[','').gsub(']','')
      part.lyric = pair[1]&.strip || ''
      unless part.chord == '' and part.lyric == ''
        line.parts << part
      end
    end
    current_section.lines << line
  end
end

# frozen_string_literal: true

require 'song_pro/version'
require 'song_pro/song'
require 'song_pro/section'
require 'song_pro/line'
require 'song_pro/part'
require 'song_pro/measure'

module SongPro
  SECTION_REGEX = /#\s*([^$]*)/
  ATTRIBUTE_REGEX = /@(\w*)=([^%]*)/
  CUSTOM_ATTRIBUTE_REGEX = /!(\w*)=([^%]*)/
  CHORDS_AND_LYRICS_REGEX = %r{(\[[\w#b\/]+\])?([\w\s',.!()_\-"]*)}i
  MEASURES_REGEX = %r{([\[[\w#b\/]+\]\s]+)[|]*}i
  CHORDS_REGEX = %r{\[([\w#b\/]+)\]?}i

  def self.parse(lines)
    song = Song.new
    current_section = nil

    lines.split("\n").each do |text|
      if text.start_with?('@')
        process_attribute(song, text)
      elsif text.start_with?('!')
        process_custom_attribute(song, text)
      elsif text.start_with?('#')
        current_section = process_section(song, text)
      else
        process_lyrics_and_chords(song, current_section, text)
      end
    end

    song
  end

  def self.process_section(song, text)
    matches = SECTION_REGEX.match(text)
    name = matches[1].strip
    current_section = Section.new(name: name)
    song.sections << current_section

    current_section
  end

  def self.process_attribute(song, text)
    matches = ATTRIBUTE_REGEX.match(text)
    key = matches[1]
    value = matches[2].strip

    if song.respond_to?("#{key}=".to_sym)
      song.send("#{key}=", value)
    else
      puts "WARNING: Unknown attribute '#{key}'"
    end
  end

  def self.process_custom_attribute(song, text)
    matches = CUSTOM_ATTRIBUTE_REGEX.match(text)
    key = matches[1]
    value = matches[2].strip

    song.set_custom(key, value)
  end

  def self.process_lyrics_and_chords(song, current_section, text)
    return if text == ''

    if current_section.nil?
      current_section = Section.new(name: '')
      song.sections << current_section
    end

    line = Line.new

    if text.start_with?('|-')
      line.tablature = text
    elsif text.start_with?('| ')
      captures = text.scan(MEASURES_REGEX).flatten

      measures = []

      captures.each do |capture|
        chords = capture.scan(CHORDS_REGEX).flatten
        measure = Measure.new
        measure.chords = chords
        measures << measure
      end

      line.measures = measures
    else
      captures = text.scan(CHORDS_AND_LYRICS_REGEX).flatten

      captures.each_slice(2) do |pair|
        part = Part.new
        chord = pair[0]&.strip || ''
        part.chord = chord.delete('[').delete(']')
        part.lyric = pair[1]&.strip || ''

        line.parts << part unless (part.chord == '') && (part.lyric == '')
      end
    end

    current_section.lines << line
  end
end

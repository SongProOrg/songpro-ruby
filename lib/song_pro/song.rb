# frozen_string_literal: true

require 'markaby'
require 'json'

module SongPro
  class Song
    attr_accessor :title,
                  :artist,
                  :capo,
                  :key,
                  :tempo,
                  :year,
                  :album,
                  :tuning,
                  :custom,
                  :sections

    def initialize
      @sections = []
      @custom = {}
    end

    def set_custom(key, value)
      @custom[key.to_sym] = value
    end

    def as_json(options={})
      {
          title: @title,
          artist: @artist,
          capo: @capo,
          key: @key,
          tempo: @tempo,
          year: @year,
          album: @album,
          tuning: @tuning,
          custom: @custom,
          sections: @sections
      }.delete_if { |k, v| v.nil? }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def chords
      sections.collect do |section|
        section.lines.collect do |line|
          if line.measures?
            line.measures.collect(&:chords)
          else
            line.parts.collect(&:chord)
          end
        end
      end.flatten.uniq.reject(&:empty?)
    end

    def to_html
      mab = Markaby::Builder.new(song: self)
      mab.div.song do
        h1.title song.title if song.title
        h2.artist song.artist if song.artist

        dl.information do
          if song.tuning
            dt.tuning 'Tuning'
            dd.tuning song.tuning
          end
          if song.capo
            dt.capo 'Capo'
            dd.capo song.capo
          end
          if song.key
            dt.key 'Key'
            dd.key song.key
          end
          if song.tempo
            dt.tempo 'Tempo'
            dd.tempo song.tempo
          end
          if song.year
            dt.year 'Year'
            dd.year song.year
          end
          if song.album
            dt.album 'Album'
            dd.album song.album
          end
        end

        song.sections.each do |section|
          div.section do
            div.name section.name
            div.lines do
              section.lines.each do |line|
                if line.tablature?
                  div.tablature do
                    line.tablature
                  end
                elsif line.measures?
                  div.measures do
                    line.measures.each do |measure|
                      div.measure do
                        measure.chords.each do |chord|
                          div.chord chord
                        end
                      end
                    end
                  end
                else
                  div.line do
                    line.parts.each do |part|
                      div.part do
                        div.chord part.chord
                        div.lyric part.lyric
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      mab.to_s
    end
  end
end

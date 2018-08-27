# frozen_string_literal: true

require 'markaby'

class Song
  attr_accessor :title,
                :artist,
                :capo,
                :key,
                :tempo,
                :year,
                :album,
                :tuning,
                :sections

  def initialize
    @sections = []
  end

  def to_html
    mab = Markaby::Builder.new(song: self)
    mab.div.song do
      h1.title song.title if song.title
      h2.artist song.artist if song.artist

      dl.information do
        if song.capo
          dt 'Capo'
          dd song.capo
        end
        if song.key
          dt 'Key'
          dd song.key
        end
        if song.tempo
          dt 'Tempo'
          dd song.tempo
        end
        if song.year
          dt 'Year'
          dd song.year
        end
        if song.album
          dt 'Album'
          dd song.album
        end
      end

      song.sections.each do |section|
        div.section do
          div.name section.name
          div.lines do
            section.lines.each do |line|
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

    mab.to_s
  end
end

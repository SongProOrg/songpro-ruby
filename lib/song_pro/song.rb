# frozen_string_literal: true

require 'markaby'

class Song
  attr_accessor :title, :artist, :capo, :sections

  def initialize
    @sections = []
  end

  def to_html
    mab = Markaby::Builder.new(song: self)
    mab.div.song do
      h1.title song.title
      h2.artist song.artist

      unless song.capo.nil?
        dl.information do
          dt 'Capo'
          dd song.capo
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

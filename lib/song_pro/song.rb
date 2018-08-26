# frozen_string_literal: true

class Song
  attr_accessor :title, :artist, :capo, :sections

  def initialize
    @sections = []
  end

  def to_html
    html = '<h1 class="title">' + @title + '</h1>' +
        '<h2 class="artist">' + @artist + '</h2>'

    html += '<dl class="information"><dt>Capo</dt><dd>' + capo + '</dd></dl>' unless capo.nil?

    @sections.each do |section|
      html += '<div class="section">' +
          '<div class="name">' + section.name + '</div>'

      html += '<div class="lines">'
      section.lines.each do |line|
        html += '<div class="line">'

        line.parts.each do |part|
          html += '<div class="part">' +
              '<div class="chord">' + part.chord + '</div>' +
              '<div class="lyric">' + part.lyric + '</div>' +
              '</div>'
        end

        html += '</div>'
      end
      html += '</div>'

      html += '</div>'
    end

    html
  end
end

# frozen_string_literal: true

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
      :sections,
      :custom

    def initialize
      @sections = []
      @custom = {}
    end

    def set_custom(key, value)
      @custom[key.to_sym] = value
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
  end
end

# frozen_string_literal: true

module SongPro
  class Line
    attr_accessor :parts, :tablature, :measures

    def initialize
      @parts = []
      @tablature = nil
      @measures = nil
    end

    def tablature?
      return @tablature != nil
    end

    def measures?
      return @measures != nil
    end

  end
end
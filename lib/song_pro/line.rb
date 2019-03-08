# frozen_string_literal: true

module SongPro
  class Line
    attr_accessor :parts, :tablature

    def initialize
      @parts = []
      @tablature = nil
    end

    def tablature?
      return @tablature != nil
    end
  end
end
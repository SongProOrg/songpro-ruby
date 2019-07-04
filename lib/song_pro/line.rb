# frozen_string_literal: true

module SongPro
  class Line
    attr_accessor :parts, :tablature, :measures, :comment

    def initialize
      @parts = []
      @tablature = nil
      @measures = nil
      @comment = nil
    end

    def tablature?
      !@tablature.nil?
    end

    def measures?
      !@measures.nil?
    end

    def comment?
      !@comment.nil?
    end
  end
end

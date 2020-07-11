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

    def as_json(options={})
      {
          parts: @parts,
          tablature: @tablature,
          measures: @measures,
          comment: @comment
      }.delete_if { |k, v| v.nil? }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
  end
end

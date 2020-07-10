# frozen_string_literal: true

module SongPro
  class Section
    attr_accessor :name, :lines

    def initialize(name: '')
      @name = name
      @lines = []
    end

    def as_json(options={})
      {
          name: @name,
          lines: @lines,
      }.delete_if { |k, v| v.nil? }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
  end
end
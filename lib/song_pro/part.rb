# frozen_string_literal: true

module SongPro
  class Part
    attr_accessor :lyric, :chord

    def as_json(options={})
      {
          lyric: @lyric,
          chord: @chord,
      }.delete_if { |k, v| v.nil? }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
  end
end
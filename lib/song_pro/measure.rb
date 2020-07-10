module SongPro
  class Measure
    attr_accessor :chords

    def initialize
      @chords = []
    end

    def as_json(options={})
      {
          chords: @chords,
      }.delete_if { |k, v| v.nil? }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
  end
end

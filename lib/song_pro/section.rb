# frozen_string_literal: true

module SongPro
  class Section
    attr_accessor :name, :lines

    def initialize(name: "")
      @name = name
      @lines = []
    end
  end
end

# frozen_string_literal: true

class Song
  attr_accessor :title, :artist, :sections

  def initialize
    @sections = []
  end
end
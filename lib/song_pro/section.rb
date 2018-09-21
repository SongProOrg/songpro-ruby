# frozen_string_literal: true

class Section
  attr_accessor :name, :lines, :reference

  def initialize(name: '', reference: nil)
    @name = name
    @reference = reference
    @lines = []
  end
end
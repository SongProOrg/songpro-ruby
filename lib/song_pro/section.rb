class Section
  attr_accessor :name, :lines

  def initialize(name: '')
    @name = name
    @lines = []
  end
end
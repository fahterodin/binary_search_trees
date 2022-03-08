require_relative 'comparable'

class Node
  include Comparable

  attr_reader :data
  attr_accessor :right, :left

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def to_s
    "  #{@data}\n#{@left}   #{right}"
  end
end

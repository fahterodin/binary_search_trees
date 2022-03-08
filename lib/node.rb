require_relative 'comparable'

class Node
  include Comparable

  attr_reader :data
  attr_accessor :right, :left

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

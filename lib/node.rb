class Node
  attr_accessor :right, :left, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def min_value
    if @left.nil?
      @data
    else
      @left.min_value
    end
  end
end

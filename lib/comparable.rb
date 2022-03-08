module Comparable
  def compare(a, b)
    case a.data <=> b.data
    when 1, 0
      a.data
    when -1
      b.data
    end
  end
end

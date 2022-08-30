# https://atcoder.jp/contests/abc134/tasks/abc134_e

class Array
  def lis
    b_ary = [self[0]]
    self[1..-1].each do |v|
      # 広義単調増加 { |x| x > v }
      # index = b_ary.bsearch_index { |x| x > v }
      # 狭義単調増加 { |x| x >= v }
      # index = b_ary.bsearch_index { |x| x >= v }
      # 広義単調減少 { |x| x < v }
      index = b_ary.bsearch_index  { |x| x < v }
      # 狭義単調減少 { |x| x <= v }
      # index = b_ary.bsearch_index { |x| x <= v }
      if index
        b_ary[index] = v
      else
        b_ary << v
      end
    end
    return b_ary.size
  end
end

n = gets.to_i
puts n.times.with_object([]) { |i,obj| obj << gets.to_i }.map { |i| i.to_i }.lis
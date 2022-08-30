require './pop_heap.rb'
require 'minitest/autorun'

class FooTest < Minitest::Test
  def test_pop_heap
    a = PopHeap.new(100)
    x = (-100..100).to_a.sample(50)
    x.concat(x.sample(50))
    x.each { |v| a.push(v) }
    y = []
    x.size.times { y << a.pop }
    assert_equal x.sort, y
  end

  def test_reverse_pop_heap
    a = ReversePopHeap.new(100)
    x = (-100..100).to_a.sample(50)
    x.concat(x.sample(50))
    x.each { |v| a.push(v)}
    y = []
    x.size.times { (y << a.pop) }
    assert_equal x.sort.reverse, y
  end
end
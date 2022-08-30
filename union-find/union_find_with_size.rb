class UnionFindWithSize
  def initialize(size)
    @rank = Array.new(size) { 0 }
    @parent = Array.new(size) { |id| id }
    @union_size = Array.new(size) { 1 }
  end

  def unite(id_x, id_y)
    x_parent = get_parent(id_x)
    y_parent = get_parent(id_y)
    return if x_parent == y_parent

    ary = [@union_size[x_parent], @union_size[y_parent]]
    if @rank[x_parent] > @rank[y_parent]
      @parent[y_parent] = x_parent
      @union_size[x_parent] += ary[1]
    else
      @parent[x_parent] = y_parent
      @union_size[y_parent] += ary[0]
      @rank[y_parent] += 1 if @rank[x_parent] == @rank[y_parent]
    end
    ary
  end

  def get_parent(id_x)
    @parent[id_x] == id_x ? id_x : (@parent[id_x] = get_parent(@parent[id_x]))
  end
end

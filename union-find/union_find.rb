class UnionFind
  def initialize(size)
    @rank = Array.new(size) { 0 }
    @parent = Array.new(size) { |id| id }
  end

  def unite(id_x, id_y)
    x_parent = get_parent(id_x)
    y_parent = get_parent(id_y)
    return if x_parent == y_parent

    if @rank[x_parent] > @rank[y_parent]
      @parent[y_parent] = x_parent
    else
      @parent[x_parent] = y_parent
      @rank[y_parent] += 1 if @rank[x_parent] == @rank[y_parent]
    end
  end

  def get_parent(id_x)
    @parent[id_x] == id_x ? id_x : (@parent[id_x] = get_parent(@parent[id_x]))
  end

  def same?(id_x, id_y)
    get_parent(id_x) == get_parent(id_y)
  end

  def size
    @parent.map { |p| get_parent(p) }.uniq.size
  end
end
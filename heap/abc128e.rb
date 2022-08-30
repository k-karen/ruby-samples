class Heap
  def initialize(n)
    @nodes = Array.new(n)
    @index = Hash.new
    @size = 0
  end

  def push(current_value)
    # 存在する値ならpushしないでreturn (入力を信じるのであれば、必要無い確認)
    return if @index[current_value]

    # 今から値を入れるのは、@size番目
    # 0番目...@size-1までの@size個の要素が元々あるから。
    current_index = @size
    @size += 1

    # 末端に要素を追加した時、その値が小さければ、どんどん親ノードへ上がっていく。
    while current_index > 0 do
      # 親ノードのindexは (i-1) >> 1 で計算できる
      # 親より自分が大きいなら、入れ替え不要でbreak
      parent_index = (current_index - 1)>>1
      parent_value = @nodes[parent_index]
      break if parent_value <= current_value

      # 親より自分が小さいので、入れ替え操作を行う。
      # 次のloopのために、current_indexを入れ替えた親のindexに直す
      @index[parent_value] = current_index
      @nodes[current_index] = parent_value
      current_index = parent_index
    end
    @index[current_value] = current_index
    @nodes[current_index] = current_value
  end

  def delete(delete_target_value)
    # 存在しない値ならdeleteできないのでreturn (入力を信じるのであれば、必要無い確認)
    return unless @index[delete_target_value]

    # 1.削除するのでsizeが減る
    # 2.末端は他のnodeと入れ替わるので、末端を削除する
    # 3.削除されるnodeのindexも削除する
    @size -= 1
    current_node_value = @nodes[@size]
    @nodes[@size] = nil
    current_node_index = @index.delete(delete_target_value) # delteの返り値は削除した値

    # 削除したのがそもそも末端だったら、終了。
    return if current_node_index == @size

    # 削除したのが末端じゃないなら、末端にある値を削除した場所に持ってくる
    @nodes[current_node_index] = current_node_value
    @index[current_node_value] = current_node_index

    # 大小関係が正されるように、要素を入れ替える

    # delete_target = d, last_node = l
    # d > l のとき
    # d_child > d > l で子は問題ないけど
    # d_parent < l < d, l < d_parent < d　のどっちかわからなくて、後者だと問題なのでチェックする
    # この問題が解決するまで、親方向にチェック & 入れ替えを続ける
    if delete_target_value > current_node_value
      parent_node_index = (current_node_index - 1) >> 1
      while @nodes[parent_node_index]&.> @nodes[current_node_index]
        change(parent_node_index, current_node_index)
        current_node_index = parent_node_index
        current_node_value = @nodes[current_node_index]
        parent_node_index = (current_node_index - 1) >> 1
      end

    # d < l のとき
    # d_parent < d < d で親は問題ないけど
    # d_child > l > d, l > d_child > d　のどっちかわからなくて、後者だと問題なのでチェックする
    # この時、(子1,子2,親) の内最小の値を新しい親にする事。
    # この問題が解決するまで、子方向にチェック & 入れ替えを続ける
    else
      while
        # 子ノードのindexを取得、小さい方(左)のindexがsize以上だったら、そこに要素は無いはずなのでbreak
        child_node_index_r = (current_node_index << 1) + 2
        child_node_index_l = child_node_index_r - 1
        break unless child_node_index_l < @size

        # 子ノードの内小さい方の値と、current_nodeを入れ替えるので、計算。
        # 右はnilの可能性があるので、右側のvalueからsafe navigation operatorを使う
        # 今のノードの値が、小さい方の子の値よりも小さかったそこでストップ
        child_node_value_l = @nodes[child_node_index_l]
        child_node_value_r = @nodes[child_node_index_r]
        if child_node_value_r&.<child_node_value_l
          min_child_value = child_node_value_r
          min_child_index = child_node_index_r
        else
          min_child_value = child_node_value_l
          min_child_index = child_node_index_l
        end
        break if min_child_value > current_node_value

        # 入れ替えた後、現在のindexを入れ替え先のindexにして、次のloopへ行く
        change(current_node_index, min_child_index)
        current_node_index = min_child_index
      end
    end
  end

  def top
    @size == 0 ? -1 : @nodes[0]
  end

  # デバッグ用
  def check_valid
    queue = [0]
    while queue.size > 0
      i = queue.shift
      child_1 = (i + 1) << 1
      child_2 = child_1 - 1
      if child_2 < @size
        if child_1 < @size
          queue << child_1
          raise if @nodes[child_1] < @nodes[i]
        end
        queue << child_2
        raise if @nodes[child_2] < @nodes[i]
      end
    end
  end

  private

  def change(index_i, index_j)
    @nodes[index_i], @nodes[index_j] = @nodes[index_j], @nodes[index_i]
    @index[@nodes[index_i]] = index_i
    @index[@nodes[index_j]] = index_j
  end
end

nn, qq = gets.split.map(&:to_i)
events = []
temp = []
1.step(nn, 1) do |_i|
  temp = gets.split.map(&:to_i)
  next if temp[1] - temp[2] <= 0
  x = temp[0] - temp[2]
  x = x > 0 ? x : 0

  events.push([temp[1] - temp[2], 1, temp[2]])
  events.push([temp[0] - temp[2], 0, temp[2]])
end
1.step(qq, 1) do |i|
  events.push([gets.to_i, 2, i])
end
events.sort_by!(&:first)

ss = Heap.new(nn)
ans = []

events.each do |event|
  if event[1] == 0
    ss.push(event[2])
  elsif event[1] == 1
    ss.delete(event[2])
  else
    ans[event[2]] = ss.top
  end
end

puts ans[1..-1]
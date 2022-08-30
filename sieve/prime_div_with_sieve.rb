# エラトステネスの篩で素数列挙して高速に素因数分解したい！
# ref: https://atcoder.jp/contests/abc177/editorial/82
class PrimeDivWithSieve
  def initialize(n)
    @sieve = [] # nまでの素数を入れる
    @min_div = {} # keyの値の最小の素因数を入れる
    # 他を篩落とし得る素数はsqrtを上限にできる
    (2..Math.sqrt(n).floor).each do |i|
      next if @min_div[i] # ここに値が入ってる = ふるい落とされている
      @sieve << i # ふるい落とされずに来たらそいつは素数

      sieve_target = i * i
      while sieve_target <= n do
        @min_div[sieve_target] ||= i
        sieve_target += i
      end
    end
    (Math.sqrt(n).floor.next..n).each do |i|
      next if @min_div[i]
      @sieve << i
    end
  end

  # Integer#prime_division と同じ値を返すようにする
  # https://docs.ruby-lang.org/ja/latest/method/Integer/i/prime_division.html
  def prime_division(num)
    return [[num, 1]] if !@min_div[num] # 素数のときすぐ返す

    return_array = [] # [[a, x], [b, y]] <=> num = a^x * b^y
    while num > 1 do
      prime = @min_div[num] # 最小の素因数, nil => numが素数
      break return_array.push([num, 1]) if !prime

      div_total = 0
      while num % prime == 0 do
        num /= prime
        div_total += 1
      end
      return_array.push([prime, div_total])
    end

    return_array
  end

  def prime_list
    @sieve
  end
end



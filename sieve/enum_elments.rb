# 素因数だけをnまで計算する
class EnumElements
  def initialize(n)
    @sieve = []
    @elements = {}
    (2..n).each do |i|
      next if @elements[i]
      @sieve << i
      @elements[i] = [i]

      sieve_target = i * 2
      while sieve_target <= n do
        if @elements[sieve_target]
          @elements[sieve_target].push(i)
        else
          @elements[sieve_target] = [i]
        end
        sieve_target += i
      end
    end
  end

  def elements(num)
    @elements[num] || []
  end
end
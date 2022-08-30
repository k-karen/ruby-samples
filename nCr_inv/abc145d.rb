MOD = (10**9) + 7
ONE = '1'.freeze

def nCk(n, k)
  (fact(k + 1, n) * inv(fact(1, n - k) % MOD)) % MOD
end

def fact(s, e)
  (s..e).reduce(1) { |r, i| (r * i) % MOD }
end

def inv(x)
  res = 1
  beki = x
  (MOD - 2).to_s(2).reverse.chars do |digest|
    res = (beki * res) % MOD if digest == ONE
    beki = (beki * beki) % MOD
  end
  res
end

x, y = gets.chomp.split.map(&:to_i)

min, max = [x, y].sort

# min,maxのdiff回多く片方の遷移をしている。
diff = max - min
d_min = min - diff
if !(d_min >= 0 && d_min == max - 2 * diff && (d_min % 3).zero?)
  puts 0
else
  a = b = d_min / 3
  a += diff
  puts nCk(a + b, b)
end

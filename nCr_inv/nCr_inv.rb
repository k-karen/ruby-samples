MOD = (10**9) + 7
ONE = '1'

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
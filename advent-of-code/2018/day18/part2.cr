T = '|'.ord.to_u8
L = '#'.ord.to_u8
P = '.'.ord.to_u8

def h(m)
  m[1..50].map{|r|r[1..50].join("")}.join("")
end

m = Array(Array(UInt8)).new(52, Array(UInt8).new())
m[0] = Array.new(52, 0u8)
m[51] = Array.new(52, 0u8)
(1..50).each {|i| m[i] = [0u8] + (gets || "").bytes + [0u8]}

ms = Hash{h(m) => 0}
y, e = 0, 1000000000
while y < e
  m2 = m.clone
  (1..50).each do |i|
    (1..50).each do |j|
      t, u = 0, 0
      (i-1..i+1).each do |k|
        (j-1..j+1).each do |l|
          unless i == k && j == l
            t += 1 if m2[k][l] == T
            u += 1 if m2[k][l] == L
          end
        end
      end
      m[i][j] = T if m2[i][j] == P && t >= 3
      m[i][j] = L if m2[i][j] == T && u >= 3
      m[i][j] = P if m2[i][j] == L && (t == 0 || u == 0)
    end
  end
  y += 1
  k = h(m)
  if ms.has_key?(k)
    p = y - ms[k]
    e = y + ((e % p) - (y % p)) % p
  else
    ms[k] = y
  end
end
t, l = m.reduce([0, 0]) { |s, x| [s[0] + x.count(T), s[1] + x.count(L)] }
puts t * l

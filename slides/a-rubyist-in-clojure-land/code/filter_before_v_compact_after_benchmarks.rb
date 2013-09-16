require 'benchmark'

$n = 100000
size = 7

puts "size: #{size}"
puts

def report
  reals = []
  Benchmark.benchmark do |bm|
    3.times do
      reals << bm.report { $n.times { yield } }.real
    end
  end

  reals.reduce(&:+) / reals.count
end

avgs = []

puts "compact after"
avgs << report {
  (1..size).
    map {|n| n*2 if n.even?}.
    compact
}

puts

puts "filter before"
avgs << report {
  (1..size).
    select {|n| n.even?}.
    map {|n| n*2}
}

puts avgs
if avgs[0] < avgs[1]
  puts "compact after faster by #{((1.0 - avgs[0]/avgs[1]) * 100).round(2)} %"
else
  puts "filter before faster by #{((1.0 - avgs[1]/avgs[0]) * 100).round(2)} %"
end

require 'benchmark'

$n = 1000000

def report(header_text)
  puts
  puts header_text
  reals = []
  Benchmark.benchmark do |bm|
    3.times do
      reals << bm.report { $n.times { yield } }.real
    end
  end

  [header_text, (reals.reduce(&:+) / reals.count).round(5)]
end

avgs = []

avgs << report("match operator with match") {
  /this pattern/ =~ "is pa"
}

avgs << report("match operator with no match") {
  /this pattern/ =~ "will not match"
}

avgs << report("match method with match") {
  /this pattern/.match "is pa"
}

avgs << report("match method with no match") {
  /this pattern/.match "will not match"
}

puts
puts avgs

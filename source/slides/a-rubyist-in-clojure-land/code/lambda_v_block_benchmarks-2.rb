require 'benchmark'

$n_runs       = 20
$n_iterations = 1000
$n_elements   = 100

puts
puts "RUBY_VERSION: #{RUBY_VERSION}"

def with_lambda
  lambda {|arg|}
end

def report(header)
  puts header
  reals = []
  Benchmark.bm do |bm|
    GC.disable
    $n_runs.times do
      reals << bm.report { $n_iterations.times { yield } }.real
    end
    GC.enable
    GC.start
  end
  puts

  [header, (reals.reduce(&:+) / reals.count).round(5)]
end

avgs = []
avgs << report("with lambda") {
  (1..$n_elements).any? &with_lambda
}

avgs << report("with block") {
  (1..$n_elements).any? {|arg|}
}

puts
puts "#{$n_runs} runs, #{$n_iterations} iterations, #{$n_elements} elements"

avgs.sort_by {|k,v| v}.each do |avg|
  puts avg.join(":\t")
end

__END__

RUBY_VERSION: 2.0.0
Array with 10 elements (10000 times)

->(){}
   0.030000   0.000000   0.030000 (  0.024788)
   0.020000   0.000000   0.020000 (  0.020165)
   0.020000   0.000000   0.020000 (  0.021286)

lambda
   0.020000   0.000000   0.020000 (  0.021530)
   0.020000   0.000000   0.020000 (  0.022711)
   0.020000   0.000000   0.020000 (  0.021984)

block
   0.020000   0.000000   0.020000 (  0.013168)
   0.010000   0.000000   0.010000 (  0.013709)
   0.010000   0.000000   0.010000 (  0.012671)

Array with 100 elements (10000 times)

->(){}
   0.080000   0.000000   0.080000 (  0.085060)
   0.090000   0.000000   0.090000 (  0.085209)
   0.090000   0.000000   0.090000 (  0.090878)

lambda
   0.080000   0.000000   0.080000 (  0.085738)
   0.090000   0.000000   0.090000 (  0.089684)
   0.090000   0.000000   0.090000 (  0.089513)

block
   0.090000   0.000000   0.090000 (  0.087005)
   0.090000   0.000000   0.090000 (  0.086726)
   0.080000   0.000000   0.080000 (  0.087101)

Array with 1000 elements (10000 times)

->(){}
   0.710000   0.000000   0.710000 (  0.714802)
   0.710000   0.000000   0.710000 (  0.711608)
   0.710000   0.000000   0.710000 (  0.711025)

lambda
   0.720000   0.010000   0.730000 (  0.715191)
   0.720000   0.000000   0.720000 (  0.718889)
   0.700000   0.000000   0.700000 (  0.709005)

block
   0.760000   0.000000   0.760000 (  0.751793)
   0.760000   0.000000   0.760000 (  0.759206)
   0.750000   0.000000   0.750000 (  0.758644)


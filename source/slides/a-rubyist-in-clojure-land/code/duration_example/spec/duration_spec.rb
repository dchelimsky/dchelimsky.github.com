require 'benchmark'
require 'active_support/core_ext'
require 'rspec/autorun'

$n = 100
$t = 3
$depth = 3

parts = [1.year, 1.day, 1.month, 2.minutes, 1.day]

v1 = parts.take($depth).reduce(&:+)
v2 = parts.take($depth).reduce(&:+)

# # original definition of Duration#inspect
# def inspect
#   consolidated = parts.inject(::Hash.new(0)) { |h,(l,r)| h[l] += r; h }
#   parts = [:years, :months, :days, :minutes, :seconds].map do |length|
#     n = consolidated[length]
#     "#{n} #{n == 1 ? length.to_s.singularize : length.to_s}" if n.nonzero?
#   end.compact
#   parts = ["0 seconds"] if parts.empty?
#   parts.to_sentence(:locale => :en)
# end

def v1.inspect
  consolidated = parts.inject(::Hash.new(0)) { |h,(l,r)| h[l] += r; h }
  parts = [:years, :months, :days, :minutes, :seconds].map do |length|
    n = consolidated[length]
    "#{n} #{n == 1 ? length.to_s.singularize : length.to_s}" if n.nonzero?
  end.compact
  parts = ["0 seconds"] if parts.empty?
  parts.to_sentence(:locale => :en)
end

def refactor_inspect(n)












def n.inspect
  val_for = parts.inject(::Hash.new(0)) { |h,(l,r)| h[l] += r; h }
  [:years, :months, :days, :minutes, :seconds].
    select {|unit| val_for[unit].nonzero? }.
    map {|unit| [unit, val_for[unit]]}.
    map {|unit, val| "#{val} #{val == 1 ? unit.to_s.singularize : unit.to_s}"}.
    tap {|units| units << "0 seconds" if units.empty?}.
    to_sentence(:locale => :en)
end











  n
end

# [[:days, 2], [:years, 1], [:months, 2], [:days, 1]]
# {:days => 3, :years => 1, :months => 2}
# [[:years, 1], [:months, 2], [:days, 3]]
# ["1 year", "2 months", "3 days"]
# "1 year, 2 months, and 3 days"

refactor_inspect(v2)

RSpec.configure {|c|
  c.include(Module.new do
    def assert_equal(e,a)
      expect(a).to eq e
    end
  end)
}

describe "Duration#inspect" do
  example "using original #inspect" do
    assert_equal '0 seconds',                       0.seconds.inspect
    assert_equal '1 month',                         1.month.inspect
    assert_equal '1 month and 1 day',               (1.month + 1.day).inspect
    assert_equal '6 months and -2 days',            (6.months - 2.days).inspect
    assert_equal '10 seconds',                      10.seconds.inspect
    assert_equal '10 years, 2 months, and 1 day',   (10.years + 2.months + 1.day).inspect
    assert_equal '7 days',                          1.week.inspect
    assert_equal '14 days',                         1.fortnight.inspect
  end

  example "using refactored #inspect" do
    assert_equal '0 seconds',                       refactor_inspect(0.seconds).inspect
    assert_equal '1 month',                         refactor_inspect(1.month).inspect
    assert_equal '1 month and 1 day',               refactor_inspect((1.month + 1.day)).inspect
    assert_equal '6 months and -2 days',            refactor_inspect((6.months - 2.days)).inspect
    assert_equal '10 seconds',                      refactor_inspect(10.seconds).inspect
    assert_equal '10 years, 2 months, and 1 day',   refactor_inspect((10.years + 2.months + 1.day)).inspect
    assert_equal '7 days',                          refactor_inspect(1.week).inspect
    assert_equal '14 days',                         refactor_inspect(1.fortnight).inspect
  end
end

def with_gc_disabled
  GC.disable
  yield
  GC.enable
  GC.start
end

def report(header)
  puts header
  reals = []
  num_objects = 0
  Benchmark.bm do |bm|
    with_gc_disabled do
      $t.times do
        reals << bm.report { $n.times { yield } }.real
      end
    end
    num_objects = ObjectSpace.each_object.map {1}.reduce(:+)
  end

  [header, (reals.reduce(&:+) / reals.count).round(5), "objects: #{num_objects}"]
end

avgs = []

avgs << report("original") {
  v1.inspect
}

puts

avgs << report("refactored") {
  v2.inspect
}

puts
puts "#{$t} runs, #{$n} iterations, #{$depth} parts"
puts

avgs.sort_by! {|(h,t,o)| t}

puts avgs.first
puts
puts avgs.last

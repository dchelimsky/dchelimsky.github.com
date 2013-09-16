require 'benchmark'

n = 100

lists = {
  "empty" => [],
  "very_short" => [1],
  "short" => (1..20),
  "medium" => (1..1_000),
  "long" => (1..100_000)
}

Benchmark.benchmark do |bm|
  %w[empty very_short short medium long].each do |name|
    list = lists[name]

    p list

    3.times do
      bm.report do
        n.times do
          list.
            map {|n| n * n if n < 10}.
            compact
        end
      end
    end

    puts

    3.times do
      bm.report do
        n.times do
          list.
            select {|n| n < 10}.
            map    {|n| n * n}
        end
      end
    end

    puts
    3.times do
      bm.report do
        n.times do
          list.
            map {|n| n * n if n > 10}.
            compact
        end
      end
    end

    puts

    3.times do
      bm.report do
        n.times do
          list.
            select {|n| n > 10}.
            map    {|n| n * n}
        end
      end
    end

    puts
  end
end

require 'wrong/adapters/rspec'

def foo(ns)
  lt_sqd_components = ->(n){
    digits = n.to_s.split('').map {|d| d.to_i}
    squares = digits.map {|d| d*d}
    sqsum = squares.reduce(&:+)
    n < sqsum
  }
  ns.select(&lt_sqd_components).length
end

describe :thing do
  example { assert { foo(1...10) == 8 } }
  example { assert { foo(1...30) == 19 } }
  example { assert { foo(1...100) == 50 } }
  example { assert { foo(1...1000) == 50 } }
end

__END__

(fn [elements]
  (let [lt-sqd-components
        (fn [n]
          (let [digits  (map #(- (int %) 48) (seq (str n)))
                squares (map #(* % %) digits)
                sqsum   (reduce + squares)]
            (if (< n sqsum)
              true
              false)))]
    (count (filter true? (map lt-sqd-components elements)))))

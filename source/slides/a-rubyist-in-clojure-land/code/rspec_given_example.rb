require 'rspec-given'

class Person
  def initialize(first, last)
    @first = first
    @last = last
  end

  def full_name
    "#{@first} #{@last}"
  end
end

describe Person do
  describe "#full_name" do
    Given(:person) { Person.new("John", "Doe") }
    Then { person.full_name == "John Doe" }
  end
end

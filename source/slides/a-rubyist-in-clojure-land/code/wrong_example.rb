require 'wrong/adapters/rspec'

class Person
  def initialize(first, last)
    @first = first
    @last = last
  end

  def full_name
    "#{@first}#{@last}"
  end
end

describe Person do
  describe "#full_name" do
    let(:person) { Person.new("John", "Doe") }
    example { assert { person.full_name == "John Doe" } }
  end
end

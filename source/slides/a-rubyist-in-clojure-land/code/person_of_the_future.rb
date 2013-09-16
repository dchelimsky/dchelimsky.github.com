require 'wrong/adapters/rspec'

class Person
  def initialize(first, last)
    @first = first
    @last = last
  end

  def full_name
    [@first, @last].compact.join(" ").strip
  end
end

class RSpec::Core::ExampleGroup
  class << self
    alias it describe
    alias wrapped_example example
    def example(&block)
      wrapped_example { assert &block }
    end
  end
end

class RSpec::Core::Formatters::DocumentationFormatter
  def example_passed(*)
    super
  end
end

describe "Person#full_name" do
  it "concats first and last names" do
    example { Person.new("John", "Doe").full_name == "John Doe" }
  end

  it "handles nils and blanks gracefully" do              # description: general
    example { Person.new(nil, "Doe").full_name == "Doe" }
    example { Person.new("",  "Doe").full_name == "Doe" } # examples: specific
    example { Person.new(" ", "Doe").full_name == "Doe" }
    example { Person.new("John", nil).full_name == "John" }
    example { Person.new("John", "" ).full_name == "John" }
    example { Person.new("John", " ").full_name == "John" }
  end
end

require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'student'

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)

class StudentTest < Minitest::Test
  def test_get_age
    student = Student.new("name", "surname", (Date.today << 12))
    assert_instance_of Integer, student.calculate_age
    assert_equal(student.calculate_age, 1, "The student's age must be 1 year")
  end

  def test_raises_error_when_birth_date_today
    error = assert_raises(ArgumentError) do
      Student.new("name", "surname", Date.today.to_s)
    end
    assert_equal "The date must be in the past", error.message
  end
end

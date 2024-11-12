require 'minitest/autorun'
require_relative 'student'

class StudentTest < Minitest::Test
  def setup
    Student.clear_students
  end
  def test_calculate_age
    student = Student.new("John", "Doe", Time.new(2000, 1, 1))
    assert_equal 24, student.calculate_age
  end
  def test_calculate_age_with_leap_year
    student = Student.new("Jane", "Smith", Time.new(2000, 2, 29))
    assert_equal 24, student.calculate_age
  end
  def test_calculate_age_for_today
    student = Student.new("Alice", "Brown", Time.now)
    assert_equal 0, student.calculate_age
  end
  def test_add_student
    student = Student.new("John", "Doe", Time.new(2000, 1, 1))
    Student.add_student(student)
    assert_includes Student.all_students, student
  end
  def test_add_student_prevents_duplicates
    student = Student.new("John", "Doe", Time.new(2000, 1, 1))
    Student.add_student(student)
    initial_count = Student.all_students.count
    Student.add_student(student)
    assert_equal initial_count, Student.all_students.count
  end
  def test_remove_student
    student = Student.new("Jane", "Smith", Time.new(1999, 5, 15))
    Student.add_student(student)
    Student.remove_student(student)
    refute_includes Student.all_students, student
  end
  def test_get_students_by_age
    student = Student.new("John", "Doe", Time.new(2000, 1, 1))
    Student.add_student(student)
    assert_includes Student.get_students_by_age(24), student
    refute_includes Student.get_students_by_age(23), student
  end
  def test_get_students_by_name
    student = Student.new("John", "Doe", Time.new(2000, 1, 1))
    Student.add_student(student)
    assert_includes Student.get_students_by_name("John"), student
    refute_includes Student.get_students_by_name("Alice"), student
  end
end
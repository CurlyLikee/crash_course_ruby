require 'date'

class Student
  attr_reader :name, :surname, :date_of_birth
  def initialize(name, surname, date_of_birth)
    @name = name
    @surname = surname
    @date_of_birth = date_of_birth
    raise ArgumentError, 'Date of birth must be in the past' if date_of_birth > Time.now
    self.class.students << self unless self.class.students.any? { |s| s.name == name && s.surname == surname && s.date_of_birth == date_of_birth }
  end
  def calculate_age
    now = Time.now
    age = now.year - @date_of_birth.year
    age -= 1 if now.yday < @date_of_birth.yday
    age
  end
  def self.students
    @students ||= []
  end
  def self.clear_students
    students.clear
  end
  def self.add_student(student)
    students << student unless students.any? { |s| s.name == student.name && s.surname == student.surname && s.date_of_birth == student.date_of_birth }
  end
  def self.remove_student(student)
    students.delete_if { |s| s.name == student.name && s.surname == student.surname && s.date_of_birth == student.date_of_birth }
  end
  def self.get_students_by_age(age)
    students.select { |student| student.calculate_age == age }
  end
  def self.get_students_by_name(name)
    students.select { |student| student.name == name }
  end
  def self.all_students
    students
  end
end
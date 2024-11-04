require 'date'

class Student
  @students = []

  attr_accessor :name, :surname
  attr_reader :age, :date_of_birth

  def initialize(name, surname, date_of_birth)
    parsed_date = Date.parse(date_of_birth)

    if parsed_date >= Date.today
      raise ArgumentError
    end

    @name = name
    @surname = surname
    @date_of_birth = parsed_date
    @age = calculate_age
    self.class.students << self
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth.next_year(age)
    age
  end

  def self.add_student(name, surname, date_of_birth)
    if students.any? { |student| student.name == name && student.surname == surname && student.date_of_birth == Date.parse(date_of_birth) }
      puts "student is already on the list"
    else
      new(name, surname, date_of_birth)
      puts "student added to list"
    end
  end

  def self.get_students_by_age(age)
    students.select { |student| student.age == age }
  end

  def self.get_students_by_name(name)
    students.select { |student| student.name == name }
  end
  def self.students
    @students
  end
end

require 'rspec'
require_relative 'student'

RSpec.describe Student do
  let(:student1) { Student.new('John', 'Doe', Time.new(2000, 1, 1)) }
  let(:student2) { Student.new('Jane', 'Smith', Time.new(1999, 5, 15)) }

  before(:each) do
    # Очищаем список студентов перед каждым тестом
    Student.clear_students
  end

  describe '#calculate_age' do
    it 'calculates the correct age' do
      expect(student1.calculate_age).to eq(24)
    end
  end

  describe '.add_student' do
    it 'adds a student to the class list' do
      Student.add_student(student1)
      expect(Student.all_students).to include(student1)
    end

    it 'does not add duplicate students' do
      Student.add_student(student1)
      initial_count = Student.all_students.count
      Student.add_student(student1)
      expect(Student.all_students.count).to eq(initial_count)
    end
  end

  describe '.remove_student' do
    it 'removes a student from the class list' do
      Student.add_student(student2)
      Student.remove_student(student2)
      expect(Student.all_students).not_to include(student2)
    end
  end

  describe '.get_students_by_age' do
    it 'returns students with the specified age' do
      Student.add_student(student1)
      expect(Student.get_students_by_age(24)).to include(student1)
      expect(Student.get_students_by_age(23)).not_to include(student1)
    end
  end

  describe '.get_students_by_name' do
    it 'returns students with the specified name' do
      Student.add_student(student1)
      expect(Student.get_students_by_name('John')).to include(student1)
      expect(Student.get_students_by_name('Alice')).not_to include(student1)
    end
  end
end
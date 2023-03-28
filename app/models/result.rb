# == Schema Information
#
# Table name: results
#
#  id                   :bigint           not null, primary key
#  actual_mark          :integer
#  for                  :integer          default("Test")
#  grade                :integer
#  name                 :string           not null
#  term                 :integer
#  total_marks          :integer
#  year                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  classroom_subject_id :bigint           not null
#  student_id           :bigint
#
# Indexes
#
#  index_results_on_classroom_subject_id  (classroom_subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_subject_id => classroom_subjects.id)
#  fk_rails_...  (student_id => users.id)
#
class Result < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:student, :classroom_subject,
                                         :year, :term, :for],
                                 message: "This result already exists"

  belongs_to :classroom_subject
  belongs_to :student, class_name: "User"

  before_validation { self.grade = student.grade }

  validates :year,
            presence: true,
            inclusion: { in: 1900..Date.today.year },
            format: {
              with: /(19|20)\d{2}/i,
              message: "should be a four-digit year",
            }

  enum term: {
    "Term 1": 1,
    "Term 2": 2,
    "Term 3": 3,
  }

  enum grade: Grades::GRADES_HASH

  enum for: {
    "Test": 0,
    "Exam": 1,
  }

  def display_name
    "#{classroom_subject.name} #{name} #{self.for}"
  end

  def papers
    student.results.where(year: year, term: term, for: "Exam",
                          classroom_subject_id: classroom_subject_id)
  end

  def grading
    MarkGrading.get percent
  end

  def percent
    (100 * actual_mark.to_f / total_marks).round
  end

  def student_position
    h = {}
    for_whole_class.each do |result|
      h[result.student_id] = result.actual_mark
    end
    h = h.sort_by { |x| x.last }
    h.reverse!
    pos = h.find_index { |x| x.first == student_id }
    pos + 1
  end

  def class_average
    (for_whole_class.sum(&:actual_mark) / for_whole_class.count.to_f).round
  end

  def total_class_average
    student.results.where(term: term, year: year, for: self.for).sum(&:class_average)
  end

  private

  def for_whole_class
    Result.where(term: term, year: year, for: self.for, classroom_subject_id: classroom_subject_id, name: name)
  end
end

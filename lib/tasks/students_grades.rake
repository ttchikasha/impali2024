namespace :students do
  desc "Upgrade/Downgrade Student Grades"

  task :upgrade, [] => [:environment] do |task|
    result1 = User.query_students_grades
    User.students.each do |student|
      puts "Upgrading #{student.full_name} (#{student.grade})"
      student.grade = User.next_grade_for_student student
      student.save!
      puts "Upgraded #{student.full_name} to (#{student.reload.grade})"
    end
    puts("Before upgrading students grades")
    puts result1
    puts("After upgrading students grades")
    puts User.query_students_grades
  end

  task :downgrade, [] => [:environment] do |task|
    result1 = User.query_students_grades
    User.students.each do |student|
      puts "Downgrading #{student.full_name} (#{student.grade})"
      student.grade = User.prev_grade_for_student student
      student.save!
      puts "Downgraded #{student.full_name} to (#{student.reload.grade})"
    end
    puts("Before downgrading students grades")
    puts result1
    puts("After downgrading students grades")
    puts User.query_students_grades
  end
end

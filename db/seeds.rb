subjects = ["Maths", "English", "Shona", "Computers", "Science", "Agriculture", "Physical Education"]

subjects.each do |name|
  Subject.create name: name
end

puts "Created #{Subject.count} Subjects"

Grades::GRADES_HASH.values.each do |grade|
  unless grade == -1
    Rooms::TYPES.each do |room|
      Classroom.create room: room, grade: grade, teacher: FactoryBot.create(:user, :teacher)
    end
  end
end

puts "Created #{Classroom.count} Classrooms"

FactoryBot.create_list :user, 10, :student

puts "Created #{User.students.count} Students"

SchoolPayment.create year: Date.today.year, term: "Term 1", levy: 85, tution: 10

puts "Created SchoolPayment"

grade = "Grade 5"
room = "Yellow"

users = FactoryBot.create_list :user, 30, :student, grade: grade, room: room

puts "Create #{users.count} students for #{grade} #{room}"

c_subs = FactoryBot.create_list :classroom_subject, rand(3..5), grade: grade, room: room

puts "Created #{c_subs.count} Classroom Subjects for #{grade} #{room}"

c_subs.each do |cs|
  assignments = FactoryBot.create_list :assignment, rand(2..4),
                                       classroom_subject: cs
  assignments.each do |a|
    questions = FactoryBot.create_list :question, rand(4..8),
                                       questionable_id: a.id,
                                       questionable_type: a.class.name
    puts "Created #{questions.count} Questions for Assignment #{a.name}"
  end

  puts "Created #{assignments.count} Assignments for #{cs.grade} #{cs.room} #{cs.name}"

  topics = FactoryBot.create_list :topic, rand(6..10), classroom_subject: cs
  puts "Created #{topics.count} topics for #{cs.grade} #{cs.room} #{cs.name}"
  topics.each do |t|
    lessons = FactoryBot.create_list :lesson, rand(10..15), topic: t
    puts "Created #{lessons.count} lessons for Topic #{t.title}"
  end
end

cs = c_subs.sample

student = FactoryBot.create \
  :user,
  :student,
  login_id: "A1234S",
  password: "secret",
  grade: grade,
  room: room

classroom = cs.classroom

classroom.teacher = FactoryBot.create \
  :user,
  :teacher,
  login_id: "A1234T",
  password: "secret"

classroom.save!

FactoryBot.create \
  :user,
  :admin,
  login_id: "A1234A",
  password: "secret"

parent = FactoryBot.create \
  :user,
  :parent,
  login_id: "A1234P",
  password: "secret"

StudentParent.create! student: student, parent: parent

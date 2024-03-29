subjects = ["Maths", "English", "Shona", "Science", "Agriculture", "Physical Education", "Information Communication Technology",
            "Family and Heritage Studies", "Visual Peforming Arts", "Family Religion and Moral Education"]

infant_subjects = ["Maths and Science", "English", "Shona", "Family and Heritage Studies", "Physical Education", "Mass Displays", "Visual Performing Arts", "Information Communication Technology"]

infant_subjects.each do |sub|
  Subject.create name: sub, target: "Infants"
end

subjects.each do |name|
  Subject.create name: name
end

puts "Created #{Subject.count} Subjects"

if Rails.env.development?
  Grades::GRADES_HASH.values.each do |grade|
    unless grade == -2
      Rooms::TYPES.each do |room|
        Classroom.create room: room, grade: grade, teacher: FactoryBot.create(:user, :teacher)
        Classroom.create room: room, grade: grade, teacher: nil
      end
    end
  end

  puts "Created #{Classroom.count} Classrooms"

  FactoryBot.create_list :user, 5, :student

  puts "Created #{User.students.count} Students"

  SchoolPayment.create year: Date.today.year, term: "Term 1", levy: 85, tution: 10

  puts "Created SchoolPayment"

  grade = "Grade 5"
  room = "Blue"

  users = FactoryBot.create_list :user, 15, :student, grade: grade, room: room

  puts "Create #{users.count} students for #{grade} #{room}"

  c_subs = []

  teacher = FactoryBot.create \
    :user,
    :teacher,
    login_id: "A1234T",
    password: "secret"

  Subject.all.sample(rand(3..Subject.count)).each do |sub|
    c_subs << FactoryBot.create(:classroom_subject, subject: sub, grade: grade, room: room, teacher: teacher)
  end

  puts "Created #{c_subs.count} Classroom Subjects for #{grade} #{room}"

  c_subs.each do |cs|
    assignments = FactoryBot.create_list :assignment, rand(1..3),
                                         classroom_subject: cs
    assignments.each do |a|
      questions = FactoryBot.create_list :question, rand(2..5),
                                         questionable_id: a.id,
                                         questionable_type: a.class.name
      puts "Created #{questions.count} Questions for Assignment #{a.name}"
    end

    puts "Created #{assignments.count} Assignments for #{cs.grade} #{cs.room} #{cs.name}"

    topics = FactoryBot.create_list :topic, rand(3..5), classroom_subject: cs
    puts "Created #{topics.count} topics for #{cs.grade} #{cs.room} #{cs.name}"
    topics.each do |t|
      lessons = FactoryBot.create_list :lesson, rand(4..7), topic: t
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

  classroom.teacher = teacher

  classroom.save!

  parent = FactoryBot.create \
    :user,
    :parent,
    login_id: "A1234P",
    password: "secret"

  StudentParent.create! student: student, parent: parent

  FactoryBot.create \
    :user,
    :sdc_member,
    login_id: "A1234M",
    password: "secret"
end

User.create first_name: "Blessed",
            last_name: "Sibanda",
            email: "blessedsibanda.me@gmail.com",
            login_id: "A1234A",
            password: "secret",
            date_of_birth: "15/08/1996",
            start_date: "15/01/2022",
            id_no: "08-2035675L53",
            role: "Admin",
            city: "Gweru",
            grade: User.grades.keys.reject { |g| g == "None" }.sample,
            room: Rooms::TYPES.sample,
            gender: "Male"

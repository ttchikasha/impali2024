User.create first_name: "Blessed", last_name: "Sibanda", email: "blessedsibanda.me@gmail.com",
            date_of_birth: Date.new(1996, 8, 15), start_date: Date.new(2022, 1, 10), gender: "Male",
            phone: "+263777330363", id_no: "08-2035675L53", role: "Admin",
            password: "secret", city: "Gweru", address: "2517 Woodlands", grade: "Grade 7", room: "Yellow"

subjects = ["Maths", "English", "Shona", "Computers", "Science", "Agriculture", "Physical Education"]

subjects.each do |name|
  Subject.create name: name
end

Grades::GRADES_HASH.values.each do |grade|
  unless grade == -1
    Rooms::TYPES.each do |room|
      Classroom.create room: room, grade: grade, teacher: FactoryBot.create(:user, :teacher)
    end
  end
end

40.times do |i|
  grades = Grades::GRADES_HASH.values.reject { |g| g == -1 }
  FactoryBot.create :user, :student, grade: grades.sample
  print "." if i % 10 == 0
end

SchoolPayment.create year: Date.today.year, term: "Term 1", levy: 85, tution: 10

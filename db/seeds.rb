User.create first_name: "Blessed", last_name: "Sibanda", email: "blessedsibanda.me@gmail.com", date_of_birth: Date.new(1996, 8, 15), start_date: Date.new(2022, 1, 10), gender: "Male", phone: "+263777330363", id_no: "08-2035675L53", role: "Admin", password: "secret", city: "Gweru", address: "2517 Woodlands", grade: "Grade 7", room: "Yellow"

subjects = ["Maths", "English", "Shona", "Computers", "Science", "Agriculture", "Physical Education"]

subjects.each do |name|
  Subject.create name: name
end

Grades::GRADES_HASH.values.each do |grade|
  unless grade == "None"
    Rooms::TYPES.each do |room|
      Classroom.create room: room, grade: grade, teacher: FactoryBot.create(:user, :teacher)
    end
  end
end

40.times do
  grades = Grades::GRADES_HASH.values.reject { |g| g == -1 }
  FactoryBot.create_list :user, 40, :student, grade: grades.sample
end

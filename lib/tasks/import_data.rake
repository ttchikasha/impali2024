namespace :import do
  desc "Import CSV users data"
  # rake import:data['data/2-blue.csv']
  task :data, [:csv_file] => [:environment] do |task, args|
    path = args[:csv_file]

    i = 0
    saved = 0
    keys = nil
    users = []
    CSV.foreach(path) do |row|
      d = Hash.new
      if i == 0
        keys = row
      else
        keys.each_with_index do |k, i|
          if k == "grade"
            if (1..7).include? row[i]
              d[k] = "Grade " + row[i]
            else
              d[k] = "ECD"
            end
          elsif k == "phone"
            if row[i]&.include? "/"
              d[k] = row[i].split("/").first
              d["phone2"] = row[i].split("/").last
            end
          else
            d[k] = row[i]
          end
        end
        if user = User.find_by_email(d["email"])
          if user.update(d)
            puts "Successfully updated #{user.reload.first_name}"
          else
            puts "Failed updating #{u.first_name} due to #{u.errors.full_messages.join("")}"
          end
        else
          u = User.new(d)
          if u.save
            puts "Created #{u.first_name}"
            saved += 1
          else
            puts "Failed creating #{u.first_name} due to #{u.errors.full_messages.join("")}"
          end
        end
        print "."
      end
      i += 1
    end

    puts "Saved new #{saved} users"
  end
end

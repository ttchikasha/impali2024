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
          if k == "phone"
            if row[i]&.include? "/"
              d[k] = row[i].split("/").first
              d["phone2"] = row[i].split("/").last
              full = d[k].starts_with?("0") || d[k].starts_with?("263") || d[k].starts_with?("+")
              full2 = d['phone2'].starts_with?("0") || d['phone2'].starts_with?("263") || d['phone2'].starts_with?("+")
              d[k] = "0" + d[k] unless full
              d['phone2'] = '0' + d['phone2'] unless full2
            else
              begin
                d[k] = row[i]
                full = d[k].starts_with?("0") || d[k].starts_with?("263") || d[k].starts_with?("+")
                d[k] = "0" + d[k] unless full
              rescue;
              end
            end
          elsif k == "room"
            d[k] = row[i].capitalize
          elsif k == "id_no"
            begin
              d[k] = row[i].upcase
            rescue
              # Ignored
            end
          elsif k == "gender"
            if row[i] == "F" || row[i] == "FEMALE"
              d[k] = "Female"
            elsif row[i] == "M" || row[i] == "MALE"
              d[k] = "Male" || row[i] == "MALE"
            else
              d[k] = row[i]
            end
          elsif k == "role"
            d[k] = row[i]&.capitalize
          elsif k == "date_of_birth"
            # reformat date from mm/dd/yyyy --> dd/mm/yyyy
            begin
              day = row[i].split[1]
              month = row[i].split("/").first
              year = row[i].split("/").last
              d[k] = Date.parse [day, month, year].join("/")
            rescue
              d[k] = ""
            end
          elsif %w[physical health].include? k
            d[k] = row[i].nil? ? "fit" : row[i].downcase
          elsif %w(first_name last_name).include? k
            d[k] = row[i]
          elsif k == 'start_date'
            begin
              d[k] = Date.parse row[i]
            rescue;
            end
          else
            d[k] = row[i]
          end
        end
        if user = User.find_by_id_no(d["id_no"]&.upcase)
          if user.update(d)
            puts "Successfully updated #{user.reload.first_name}"
          else
            puts "Failed updating #{user.first_name} due to #{user.errors.full_messages.join("")}"
          end
        else
          d['email'] = d['first_name'].downcase + d["last_name"].downcase + rand(999).to_s + "@example.co.zw"
          d['email'] = d['email'].gsub(' ', '')
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

    # debugger
    puts "Saved new #{saved} users"
  end
end

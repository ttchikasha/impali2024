require "roo"

namespace :import do
  desc "Import users from spreadsheet"
  # rake import:users['users.xlsx']
  task :users, [:file] => [:environment] do |task, args|
    puts "Importing Users Data from #{args[:file]}"

    data = Roo::Spreadsheet.open(args[:file])

    headers = data.row 1

    data.each_with_index do |row, idx|
      next if idx.zero? # skip header

      # create hash from headers and cells
      user_data = Hash[[headers, row].transpose]

      if User.exists?(email: user_data["email"])
        puts "User with email '#{user_data["email"]}' already exists"
        next
      end

      user = User.new user_data
      puts "Saving user with email #{user.email}"
      user.save!
    end
  end
end

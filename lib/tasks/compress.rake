require "fileutils"

namespace :compress do
  desc "Compress Images"
  # rake compress:images['/home/my_images/']
  task :images, [:src_dir] => [:environment] do |task, args|
    src_dir = args[:src_dir]

    dest_dir = rand(10000..99999).to_s
    FileUtils.cp_r src_dir, dest_dir
    d = Dir.new dest_dir

    d.entries.each_with_index do |entry, index|
      f = File.join d.path, entry
      if File.file? f
        ImageOptimizer.new(f.pathmap, quality: 50).optimize

        filename = File.basename f, File.extname(f)
        File.rename f, d.path + "/" + (index + 1).to_s + File.extname(f)
      end
    end

    puts("images compressed and written to #{dest_dir}")
  end
end

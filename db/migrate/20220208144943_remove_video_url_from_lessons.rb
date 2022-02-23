class RemoveVideoUrlFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :video_url
  end
end

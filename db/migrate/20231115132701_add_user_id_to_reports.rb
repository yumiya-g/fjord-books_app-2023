class AddUserIdToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :user_id, :intger
  end
end

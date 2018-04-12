class AddLeaderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :leader, :boolean
  end
end

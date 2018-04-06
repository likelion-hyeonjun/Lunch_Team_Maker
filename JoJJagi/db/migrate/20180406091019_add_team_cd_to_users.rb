class AddTeamCdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :team_cd, :integer, default:0
  end
end

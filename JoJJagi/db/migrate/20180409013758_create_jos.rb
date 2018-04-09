class CreateJos < ActiveRecord::Migration[5.1]
  def change
    create_table :jos do |t|
      t.text :description

      t.timestamps
    end
  end
end

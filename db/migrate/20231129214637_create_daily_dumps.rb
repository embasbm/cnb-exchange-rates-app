class CreateDailyDumps < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_dumps do |t|
      t.string :file_name
      t.jsonb :payload

      t.timestamps
    end

    add_index :daily_dumps, :file_name, unique: true
  end
end

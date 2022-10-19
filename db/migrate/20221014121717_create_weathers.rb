class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.datetime :observ_date_time, null: false
      t.integer :epoch_time, null: false
      t.text :weather_text
      t.decimal :temperature, precision: 2, scale: 2, null: false
      t.integer :weather_type, null: false, default: 0

      t.timestamps
    end
  end
end

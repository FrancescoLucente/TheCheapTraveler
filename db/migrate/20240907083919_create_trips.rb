class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :trip_type
      t.string :departure_airport_outbound
      t.string :arrival_airport_outbound
      t.datetime :departure_time_outbound
      t.datetime :arrival_time_outbound
      t.integer :duration_outbound
      t.integer :stop_count_outbound
      t.boolean :is_direct_outbound
      t.string :departure_airport_inbound
      t.string :arrival_airport_inbound
      t.datetime :departure_time_inbound
      t.datetime :arrival_time_inbound
      t.integer :duration_inbound
      t.integer :stop_count_inbound
      t.boolean :is_direct_inbound
      t.decimal :total_price
      t.integer :total_duration
      t.boolean :is_change_allowed
      t.boolean :is_cancellation_allowed

      t.timestamps
    end
  end
end

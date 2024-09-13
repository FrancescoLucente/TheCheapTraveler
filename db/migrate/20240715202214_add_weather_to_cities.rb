class AddWeatherToCities < ActiveRecord::Migration[7.1]
  def change
    add_column :cities, :temperature, :float
    add_column :cities, :weather_description, :string
    add_column :cities, :weather_datetime, :datetime
  end
end

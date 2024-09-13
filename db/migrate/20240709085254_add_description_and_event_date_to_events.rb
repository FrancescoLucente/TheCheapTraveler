class AddDescriptionAndEventDateToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :description, :text
    add_column :events, :event_date, :datetime
  end
end

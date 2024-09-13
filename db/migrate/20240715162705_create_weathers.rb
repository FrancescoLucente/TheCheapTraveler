class CreateWeathers < ActiveRecord::Migration[7.1]
  def change
    create_table :weathers do |t|
      t.references :city, null: false, foreign_key: true
      t.float :temperature
      t.text :description
      t.datetime :datetime

      t.timestamps
    end
  end
end

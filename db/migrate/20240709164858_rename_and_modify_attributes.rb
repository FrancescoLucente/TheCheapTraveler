class RenameAndModifyAttributes < ActiveRecord::Migration[7.1]
  def change
      rename_column :events, :date, :end_date

         
         add_column :events, :entity_id, :string
         
  end
end

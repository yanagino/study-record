class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.date :date
      t.float :hour
      t.text :content
      t.text :memo
      t.text :study
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.integer :frequency, default: 1

      t.timestamps
    end
  end
end

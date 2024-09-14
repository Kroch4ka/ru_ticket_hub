class CreateOperators < ActiveRecord::Migration[7.1]
  def change
    create_table :operators do |t|
      t.integer :role, null: false, default: 0
      t.timestamps
    end
  end
end

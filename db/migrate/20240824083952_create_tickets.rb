class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title, limit: 255, null: false
      t.text :description, null: false
      t.integer :priority, null: false, default: 0
      t.string :aasm_state
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end

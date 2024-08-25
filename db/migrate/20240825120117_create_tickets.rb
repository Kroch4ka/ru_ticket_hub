class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :rating
      t.string :aasm_state
      t.references :company, null: false, foreign_key: true
      t.references :operator, foreign_key: { to_table: :users }
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end

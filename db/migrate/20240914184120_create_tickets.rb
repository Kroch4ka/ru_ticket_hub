class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.string :status
      t.references :operator, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :body, null: false
      t.references :author, null: false, foreign_key: { to_table: :profiles }
      t.references :ticket, null: false, foreign_key: true
      t.timestamps
    end
  end
end

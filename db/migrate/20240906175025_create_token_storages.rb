class CreateTokenStorages < ActiveRecord::Migration[7.1]
  def change
    create_table :token_storages do |t|
      t.string :token, null: false, index: { unique: true }
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :phone_number
      t.string :profileable_type
      t.string :profileable_id
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end

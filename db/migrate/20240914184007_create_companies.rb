# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.text :description
      t.string :email
      t.string :website
      t.string :inn
      t.boolean :active, default: false, null: false
      t.timestamps
    end
  end
end

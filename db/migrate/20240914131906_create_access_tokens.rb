# frozen_string_literal: true

class CreateAccessTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :access_tokens do |t|
      t.string :token, null: false, index: { unique: true }
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end

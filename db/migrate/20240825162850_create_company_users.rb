class CreateCompanyUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :company_users do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.timestamps
    end
  end
end

class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|

      t.timestamps
    end
  end
end

class CreateVerificators < ActiveRecord::Migration[7.1]
  def change
    create_table :verificators do |t|

      t.timestamps
    end
  end
end

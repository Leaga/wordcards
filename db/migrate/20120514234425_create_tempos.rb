class CreateTempos < ActiveRecord::Migration
  def change
    create_table :tempos do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end

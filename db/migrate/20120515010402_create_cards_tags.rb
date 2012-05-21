class CreateCardsTags < ActiveRecord::Migration
  def change
    create_table :cards_tags do |t|
      t.integer :card_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

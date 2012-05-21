class AddImageLinkToCards < ActiveRecord::Migration
  def change
    add_column :cards, :image_src, :string
  end
end

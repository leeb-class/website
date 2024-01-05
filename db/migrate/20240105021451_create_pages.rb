class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.text :content
      t.string :title
      t.boolean :visible
      t.boolean :editable
      t.string :url
      t.integer :order

      t.timestamps
    end
  end
end

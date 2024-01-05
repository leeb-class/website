class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :title
      t.string :subtitle
      t.string :page_title

      t.timestamps
    end
  end
end

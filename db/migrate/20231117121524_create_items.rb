class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,   null: false
      t.string :name,        null: false
      t.integer :value,      null: false
      t.text :explanation,   null: false
      t.boolean :is_on_sale, null: false ,default: true
      t.timestamps
    end
  end
end

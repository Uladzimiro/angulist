class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :group, index: true
      t.string :title
      t.integer :priority
      t.date :complete_on
      t.boolean :completed, default: false
      t.integer :sort_order

      t.timestamps
    end
  end
end

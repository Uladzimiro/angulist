class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :user, index: true
      t.string :title
      t.integer :sort_order

      t.timestamps
    end
  end
end

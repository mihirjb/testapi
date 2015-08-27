class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.string :price
      t.string :location

      t.timestamps
    end
  end
end

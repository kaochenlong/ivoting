class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus do |t|
      t.references :product, foreign_key: true
      t.integer :quantity, default: 0
      t.string :spec

      t.timestamps
    end
  end
end

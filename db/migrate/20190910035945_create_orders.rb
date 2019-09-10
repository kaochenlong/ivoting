class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :recipient
      t.string :phone
      t.string :address
      t.text :note
      t.string :status

      t.timestamps
    end
  end
end

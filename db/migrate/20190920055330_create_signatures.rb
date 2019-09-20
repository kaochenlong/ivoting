class CreateSignatures < ActiveRecord::Migration[5.2]
  def change
    create_table :signatures do |t|
      t.references :candidate, foreign_key: true
      t.string :content
      t.boolean :active, default: false

      t.timestamps
    end
  end
end

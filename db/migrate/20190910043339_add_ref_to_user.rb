class AddRefToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference(:orders, :user)
  end
end

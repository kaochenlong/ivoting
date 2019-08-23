class AddDegreeToCandidate < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :degree, :string
  end
end

class Userclassname < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :administrator, foreign_key: {to_table: :users}
  end
end

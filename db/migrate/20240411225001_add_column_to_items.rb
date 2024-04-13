class AddColumnToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :status, :integer, default: 1
  end
end

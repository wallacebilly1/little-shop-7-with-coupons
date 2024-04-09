class ChangeTransactionsFieldDataType < ActiveRecord::Migration[7.1]
  def change
    change_column(:transactions, :credit_card_number, :string)
  end
end

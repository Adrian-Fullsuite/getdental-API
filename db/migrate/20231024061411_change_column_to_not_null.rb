class ChangeColumnToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_default :appointments, :is_paid, false
    change_column_default :appointments, :status, "pending"
  end
end

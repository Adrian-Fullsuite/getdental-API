class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :age
      t.string :email_address
      t.string :password_digest

      t.timestamps
    end
  end
end
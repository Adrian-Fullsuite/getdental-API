class CreateDentists < ActiveRecord::Migration[7.1]
  def change
    create_table :dentists do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email_address
      t.string :password_digest

      t.timestamps
    end
  end
end

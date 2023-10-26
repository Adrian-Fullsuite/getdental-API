class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.datetime :date_of_appointment
      t.references :dentist, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.boolean :is_paid
      t.string :status

      t.timestamps
    end
  end
end

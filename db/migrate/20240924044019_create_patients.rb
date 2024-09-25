class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :address
      t.string :password_digest
      t.string :medical_history

      t.timestamps
    end

    add_index :patients, :email, unique: true

  end
end

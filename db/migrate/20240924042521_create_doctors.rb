class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :speciality
      t.text :bio
      t.string :password_digest
      t.integer :availability, default:0

      t.timestamps
    end

    add_index :doctors, :email, unique: true
  end
end

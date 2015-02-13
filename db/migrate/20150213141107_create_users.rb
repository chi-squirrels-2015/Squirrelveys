class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, :password_hash, :email, :profile_picture

      t.timestamps
    end
  end
end

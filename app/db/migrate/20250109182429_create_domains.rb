class CreateDomains < ActiveRecord::Migration[8.0]
  def change
    create_table :domains do |t|
      t.string :domain_name
      t.integer :password_expiration_date

      t.timestamps
    end
  end
end

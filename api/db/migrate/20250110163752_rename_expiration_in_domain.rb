class RenameExpirationInDomain < ActiveRecord::Migration[8.0]
  def change
    rename_column :domains, :password_expiration_date, :password_expiration_frequency
  end
end

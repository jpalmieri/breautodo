class AuthTokenNonNullable < ActiveRecord::Migration
  def change
    change_column :users, :auth_token, :string, :null => false
  end
end

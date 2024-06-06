class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      # バリーデーション未設定なため、, null: false追加
      t.string :mail, null: false
      t.string :password_digest, null: false
      t.timestamps null: false
    end
  end
end

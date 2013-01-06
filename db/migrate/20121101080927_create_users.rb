class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.string :name, :null => false
      t.string :nickname
      t.string :image
      t.string :token

      t.timestamps
    end
  end
end
class AddUserImageToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_image, :string
  end
end

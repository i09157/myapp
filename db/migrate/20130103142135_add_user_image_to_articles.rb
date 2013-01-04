class AddUserImageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_image, :string
  end
end

class AddUserImageToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :user_image, :string
  end
end

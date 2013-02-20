#encoding: utf-8
ActiveAdmin.register Article do
  index do
    column "タイトル" do |article|
      link_to article.title, admin_article_path(article)
    end
    column "カテゴリ",:category_name
    column "作成日",:created_at
    column "更新日",:updated_at
    column "ユーザ", :user
  end

  # filter setting
  filter :user, :as => :select
  filter :category, :as => :check_boxes
  filter :title
  filter :title
  filter :created_at
  # ...省略
end

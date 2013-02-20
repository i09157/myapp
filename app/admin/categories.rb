#encoding: utf-8
ActiveAdmin.register Category do
    index do
    column "カテゴリ名",:name
    column "作成日",:created_at
    default_actions                   
    
  end

  filter :name
  filter :created_at
end

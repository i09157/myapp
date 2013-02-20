class Category < ActiveRecord::Base
  attr_accessible :name, :as => :admin
  has_many :articles
end

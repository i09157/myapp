class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  has_many :articles
  has_many :comments
  def self.create_with_omniauth(auth)
    create!do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.nickname
      user.image = auth.info.image
    end
  end
end

class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid,:admin
  acts_as_followable
  acts_as_follower 
  has_many :articles
  has_many :questions
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

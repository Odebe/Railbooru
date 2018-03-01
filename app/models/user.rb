class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :posts
  #has_many :pools


  attr_accessor :login

  def login=(login)
  	@login = login
  end

  def login
  	@login || self.username #|| self.email
  end
end

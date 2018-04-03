class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :posts
  has_many :pools
  #has_many :created_moderate_tasks, class_name: 'ModerateTask', foreign_key: 'creator_id'
  #has_many :passsed_moderate_tasks, class_name: 'ModerateTask', foreign_key: 'passer_id'

  attr_accessor :login

  def login=(login)
  	@login = login
  end

  def login
  	@login || self.username #|| self.email
  end
end

class User < ApplicationRecord

  validates_presence_of :name

  has_and_belongs_to_many :bikes, through: :trips

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

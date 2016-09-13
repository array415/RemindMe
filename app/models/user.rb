class User < ApplicationRecord
  has_secure_password
  has_many :meds
  has_many :alerts

  validates :name, :email, :phone_num, :password, presence: true
  validates :email, :phone_num, uniqueness: true


  before_save :strip_number

  def strip_number
    self.phone_num = self.phone_num.gsub(/\D/,"")
  end

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end
end

class User < ApplicationRecord
  has_secure_password
  has_many :meds
  has_many :alerts

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end
end

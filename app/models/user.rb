class User < ApplicationRecord
  has_secure_password
  has_many :meds
  has_many :alerts

  validates :name, :email, :phone_num, :password, presence: true
  validates_uniqueness_of :phone_num, :email
  # TODO: check validation for edits. (fun times!)
  validates_format_of :phone_num, with: /\d{3}-\d{3}-\d{4}/, message: 'Is invalid please enter a valid U.S phone number e.g.(555-555-5555)'


  before_save :strip_number

  def strip_number
    self.phone_num = self.phone_num.gsub(/\D/,"")
  end

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end
end

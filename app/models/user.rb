class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 has_secure_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rooms, dependent: :destroy
  has_one :profile
  has_many :bookings, dependent: :destroy
  has_many :booked_rooms, through: :bookings, source: :room

  def has_profile?
    profile.present?
  end

  def full_name
    profile.full_name
  end
end

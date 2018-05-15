class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :votes
  has_one :nickname, :dependent => :destroy
  accepts_nested_attributes_for(:nickname, allow_destroy: true)

  attr_accessor :skip_password_validation

    private

           def password_required?
                 return false if skip_password_validation
              super
           end
end



class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, format: {with: /@/, message: "must have an @"}
end

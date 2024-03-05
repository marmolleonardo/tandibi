# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  is_public  :boolean
#  last_name  :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  }

  has_many :posts
  has_many :bonds
  has_many :friends, through: :bonds
  has_many :followings,
    -> { where("bonds.state = ?", Bond::FOLLOWING) },
    through: :bonds,
    source: :friend
  has_many :inward_bonds,
    class_name: "Bond",
    foreign_key: :friend_id
  has_many :follow_requests,
    -> { Bond.requesting },
    through: :bonds,
    source: :friend
  has_many :followers,
    -> { Bond.following },
    through: :inward_bonds,
    source: :user
end

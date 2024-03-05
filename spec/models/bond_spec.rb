# == Schema Information
#
# Table name: bonds
#
#  id         :bigint           not null, primary key
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_bonds_on_user_id_and_friend_id  (user_id,friend_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Bond, type: :model do
  describe "#valid?" do
    it "should validate the state correctly" do
      friend = create(:user)
      user = create(:user)
      bond = Bond.new(
        user_id: user.id,
        friend_id: friend.id
      )
      expect(bond).not_to be_valid
      Bond::STATES.each do |state|
        bond.state = state
        expect(bond).to be_valid
      end
    end
  end

  describe "#followings" do
    it "can list all of the user's followings" do
      user = create(:user)
      friend1 = create(:user)
      friend2 = create(:user)
      friend3 = create(:user)
      Bond.create user: user,
        friend: friend1,
        state: Bond::FOLLOWING
      Bond.create user: user,
        friend: friend2,
        state: Bond::FOLLOWING
      Bond.create user: user,
        friend: friend3,
        state: Bond::REQUESTING
      expect(user.followings).to include(friend1, friend2)
      expect(user.follow_requests).to include(friend3)
    end
  end

  describe "#followers" do
    it "can list all of the user's followers" do
      user1 = create(:user)
      user2 = create(:user)
      fol1 = create(:user)
      fol2 = create(:user)
      fol3 = create(:user)
      fol4 = create(:user)
      Bond.create user: fol1,
        friend: user1,
        state: Bond::FOLLOWING
      Bond.create user: fol2,
        friend: user1,
        state: Bond::FOLLOWING
      Bond.create user: fol3,
        friend: user2,
        state: Bond::FOLLOWING
      Bond.create user: fol4,
        friend: user2,
        state: Bond::REQUESTING
      expect(user1.followers).to eq([fol1, fol2])
      expect(user2.followers).to eq([fol3])
    end
  end

  describe "#save" do
    context "when complete data is given" do
      it "can be persisted" do
        user = create(:user)
        friend = create(:user)
        bond = Bond.new(
          user: user,
          friend: friend,
          state: Bond::REQUESTING
        )
        bond.save
        expect(bond).to be_persisted
        expect(bond.user).to eq user
        expect(bond.friend).to eq friend
      end
    end
  end
end

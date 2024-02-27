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

  describe "validations" do
    it { should validate_presence_of(:state) }
    it { should validate_inclusion_of(:state).in_array(Bond::STATES) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe "uniqueness" do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    it "should not allow duplicate bonds between the same users" do
      bond1 = Bond.create(user: user, friend: friend, state: Bond::REQUESTING)
      bond2 = Bond.new(user: user, friend: friend, state: Bond::FOLLOWING)
      expect(bond2).to_not be_valid
    end
  end

  describe "states" do
    it "should define the following states: requesting, following, blocking" do
      expect(Bond::STATES).to eq(%w[requesting following blocking])
    end
  end
end


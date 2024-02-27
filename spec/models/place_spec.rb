# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  coordinate :geometry         point, 0
#  locale     :string
#  name       :string
#  place_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_places_on_coordinate             (coordinate) USING gist
#  index_places_on_locale                 (locale)
#  index_places_on_locale_and_coordinate  (locale,coordinate) UNIQUE
#
require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

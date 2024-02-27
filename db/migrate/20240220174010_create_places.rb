class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :locale
      t.st_point :coordinate
      t.string :name
      t.string :place_type

      t.timestamps
    end

    add_index :places, :locale
    add_index :places, :coordinate, using: :gist
    add_index :places, [:locale, :coordinate], unique: true
  end
end

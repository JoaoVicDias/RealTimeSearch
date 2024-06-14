class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :content
      t.string :user
      t.integer :count

      t.timestamps
    end
  end
end

class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, limit: 50
      t.timestamps
    end
  end
end

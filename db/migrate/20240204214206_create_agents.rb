class CreateAgents < ActiveRecord::Migration[7.1]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :role
      t.string :ability_name
      t.text :ability_description
      t.text :description
      t.string :img_path

      t.timestamps
    end
  end
end

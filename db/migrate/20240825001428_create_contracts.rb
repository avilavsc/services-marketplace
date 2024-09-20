class CreateContracts < ActiveRecord::Migration[7.2]
  def change
    create_table :contracts do |t|
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end

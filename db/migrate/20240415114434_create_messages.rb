class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: true, foreign_key: {to_table: :users}
      t.references :receiver, null: false, foreign_key: true, foreign_key: {to_table: :users}
      t.string :content, null: false

      t.timestamps
    end
  end
end

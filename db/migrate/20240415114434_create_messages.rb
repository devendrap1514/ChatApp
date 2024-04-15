class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :receiver
      t.string :content

      t.timestamps
    end
  end
end

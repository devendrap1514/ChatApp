class ChangeMessageTableToPolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :receiver_id, :bigint
    add_reference :messages, :receivable, polymorphic: true, null: false
  end
end

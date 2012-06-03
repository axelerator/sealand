class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :plan_attachment
      t.references :user
      t.references :plan
      t.timestamps
    end
    add_index :attachments, :plan_id
    add_index :attachments, :user_id
  end
end

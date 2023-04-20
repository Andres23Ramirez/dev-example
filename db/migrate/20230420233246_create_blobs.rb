class CreateBlobs < ActiveRecord::Migration[7.0]
  def change
    create_table :blobs do |t|
      t.string :document_id
      t.string :document_filename
      t.text :data

      t.timestamps
    end
  end
end

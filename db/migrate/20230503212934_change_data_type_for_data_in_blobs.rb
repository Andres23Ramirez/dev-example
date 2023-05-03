class ChangeDataTypeForDataInBlobs < ActiveRecord::Migration[7.0]
  def up
    change_column :blobs, :data, :json, using: 'data::json'
  end

  def down
    change_column :blobs, :data, :text
  end
end

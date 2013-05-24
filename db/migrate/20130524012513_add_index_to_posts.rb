class AddIndexToPosts < ActiveRecord::Migration
  def change
  end

  add_index :posts, [:admin_id, :created_at]
end

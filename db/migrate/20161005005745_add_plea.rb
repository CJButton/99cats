class AddPlea < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :plea, :text
  end
end

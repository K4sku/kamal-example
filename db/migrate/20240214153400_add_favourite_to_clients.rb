class AddFavouriteToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :favourite, :boolean, default: false
  end
end

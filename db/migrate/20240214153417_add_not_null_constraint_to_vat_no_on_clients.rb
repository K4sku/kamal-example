class AddNotNullConstraintToVatNoOnClients < ActiveRecord::Migration[7.1]
  def change
    change_column_null :clients, :vat_no, false
  end
end

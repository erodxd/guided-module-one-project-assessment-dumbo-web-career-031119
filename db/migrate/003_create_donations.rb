class CreateDonations < ActiveRecord::Migration[5.1]
    def change
    create_table :donations do |t|
      t.float :amount_donated
      t.integer :campaign_id
      t.integer :donor_id
    end
    
end      
end
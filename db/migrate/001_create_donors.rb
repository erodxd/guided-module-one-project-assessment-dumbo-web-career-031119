class CreateDonors < ActiveRecord::Migration[5.1]
    def change
    create_table :donors do |t|
      t.string :name
      t.string :industry
    end
    
end      
end
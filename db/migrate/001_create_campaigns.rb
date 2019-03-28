class CreateCampaigns < ActiveRecord::Migration[5.1]
    def change
    create_table :campaigns do |t|
      t.string :name
      t.string :party
    end
    
end      
end
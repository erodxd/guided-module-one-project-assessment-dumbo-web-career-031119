class AddDonorToDonations < ActiveRecord::Migration[5.1]
    def change
      add_column :donations, :donor_id, :integer
    end
  end